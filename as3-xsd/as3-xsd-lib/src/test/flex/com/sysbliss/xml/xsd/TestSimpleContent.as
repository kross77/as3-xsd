package com.sysbliss.xml.xsd
{
import com.sysbliss.xml.xsd.model.SysblissContent;
import com.sysbliss.xml.xsd.util.XMLDecoder;

import mx.core.ByteArrayAsset;
import mx.rpc.events.SchemaLoadEvent;
import mx.rpc.xml.Schema;
import mx.rpc.xml.SchemaLoader;
import mx.rpc.xml.SchemaManager;
import mx.rpc.xml.SchemaTypeRegistry;

import org.flexunit.Assert;
import org.flexunit.async.Async;

public class TestSimpleContent
{
    [Embed(source="/simpleContentTest.xsd", mimeType="application/octet-stream")]
    public static const simpleContentXSD:Class;

    public static var xmlDecoder:XMLDecoder;

    [BeforeClass]
    public static function setupDecoder():void {
        var ba:ByteArrayAsset = ByteArrayAsset( new simpleContentXSD() );
        var xsd:XML = new XML( ba.readUTFBytes( ba.length ) );

        var schema:Schema = new Schema(xsd);
        var schemaManager:SchemaManager = new SchemaManager();

        schemaManager.addSchema(schema);
        xmlDecoder = new XMLDecoder();
        xmlDecoder.schemaManager = schemaManager;

    }

    [Test]
    public function castSimpleContentToCustomObject():void
    {
        var testXml:XML = <SysblissContent version="1.0.0">It Worked!</SysblissContent>;

        var registry:SchemaTypeRegistry = SchemaTypeRegistry.getInstance();
        registry.registerClass(new QName("", "SysblissContent_type"), SysblissContent);

        var qName:QName = new QName("", "SysblissContent");
        var obj:Object = xmlDecoder.decode(testXml, qName);

        Assert.assertTrue((obj is SysblissContent));

        var sysblissContent:SysblissContent = obj as SysblissContent;

        Assert.assertEquals("1.0.0", sysblissContent.version);
        Assert.assertEquals("It Worked!", sysblissContent.value);
    }

}
}