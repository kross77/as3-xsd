package com.sysbliss.xml.xsd
{
import com.sysbliss.xml.xsd.model.ChoiceHolder;
import com.sysbliss.xml.xsd.model.SysblissContent;
import com.sysbliss.xml.xsd.model.TypeWithDescType;
import com.sysbliss.xml.xsd.model.TypeWithIdType;
import com.sysbliss.xml.xsd.model.TypeWithNameType;
import com.sysbliss.xml.xsd.util.XMLDecoder;

import mx.core.ByteArrayAsset;
import mx.rpc.xml.Schema;
import mx.rpc.xml.SchemaManager;
import mx.rpc.xml.SchemaTypeRegistry;

import org.flexunit.Assert;

public class TestChoice
{
    [Embed(source="/choiceTest.xsd", mimeType="application/octet-stream")]
    public static const XSD:Class;

    public static var xmlDecoder:XMLDecoder;

    [BeforeClass]
    public static function setupDecoder():void {
        var ba:ByteArrayAsset = ByteArrayAsset( new XSD() );
        var xsd:XML = new XML( ba.readUTFBytes( ba.length ) );

        var schema:Schema = new Schema(xsd);
        var schemaManager:SchemaManager = new SchemaManager();

        schemaManager.addSchema(schema);
        xmlDecoder = new XMLDecoder();
        xmlDecoder.schemaManager = schemaManager;

        var registry:SchemaTypeRegistry = SchemaTypeRegistry.getInstance();
        registry.registerClass(new QName(schema.targetNamespace.uri, "ChoiceHolder"), ChoiceHolder);
        registry.registerClass(new QName(schema.targetNamespace.uri, "TypeWithId"), TypeWithIdType);
        registry.registerClass(new QName(schema.targetNamespace.uri, "TypeWithName"), TypeWithNameType);
        registry.registerClass(new QName(schema.targetNamespace.uri, "TypeWithDesc"), TypeWithDescType);

    }

    [Test]
    public function typeWithIdIsChosen():void
    {
       var testXml:XML = <ChoiceHolder><TypeWithId id="1">i have an id</TypeWithId></ChoiceHolder>;

        var qName:QName = new QName("", "ChoiceHolder");
        var choice:ChoiceHolder = xmlDecoder.decode(testXml, qName) as ChoiceHolder;

        Assert.assertTrue(choice.isId());
        Assert.assertFalse(choice.isName());
        Assert.assertFalse(choice.isDesc());
    }

    [Test]
    public function typeWithNameIsChosen():void
    {
        var testXml:XML = <ChoiceHolder><TypeWithName name="Bob"/></ChoiceHolder>;

        var qName:QName = new QName("", "ChoiceHolder");
        var choice:ChoiceHolder = xmlDecoder.decode(testXml, qName) as ChoiceHolder;

        Assert.assertFalse(choice.isId());
        Assert.assertTrue(choice.isName());
        Assert.assertFalse(choice.isDesc());
    }

    [Test]
    public function typeWithDescIsChosen():void
    {
        var testXml:XML = <ChoiceHolder><TypeWithDesc desc="this is descriptive"/></ChoiceHolder>;

        var qName:QName = new QName("", "ChoiceHolder");
        var choice:ChoiceHolder = xmlDecoder.decode(testXml, qName) as ChoiceHolder;

        Assert.assertFalse(choice.isId());
        Assert.assertFalse(choice.isName());
        Assert.assertTrue(choice.isDesc());
    }
}
}