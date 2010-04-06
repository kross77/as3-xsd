package com.sysbliss.xml.xsd
{
import com.sysbliss.util.AbstractClassEnforcer;

import com.sysbliss.xml.xsd.util.XMLDecoder;

import flash.events.EventDispatcher;

import mx.rpc.events.FaultEvent;
import mx.rpc.events.SchemaLoadEvent;
import mx.rpc.xml.Schema;
import mx.rpc.xml.SchemaLoader;
import mx.rpc.xml.SchemaManager;
import mx.rpc.xml.SchemaTypeRegistry;

public class AbstractXSDSupport extends EventDispatcher
{
    protected var schema:Schema;
    protected var schemaLoader:SchemaLoader;
    protected var schemaManager:SchemaManager;
    protected var schemaLoaded:Boolean = false;

    public function AbstractXSDSupport()
    {
        AbstractClassEnforcer.enforceConstructor(this,AbstractXSDSupport);
        this.schemaLoaded = false;
        this.schemaLoader = new SchemaLoader();
        this.schemaManager = new SchemaManager();

        schemaLoader.addEventListener(SchemaLoadEvent.LOAD,onSchemaLoaded);
        schemaLoader.addEventListener(FaultEvent.FAULT, onSchemaLoadFault);
    }

    protected function createSchema(xml:XML):void {
        this.schema = new Schema(xml);
        this.schemaLoaded = true;

        schemaManager.addSchema(schema);
        registerSchemaClasses(schema, SchemaTypeRegistry.getInstance());
    }

    protected function onSchemaLoaded(e:SchemaLoadEvent):void {
        this.schema = e.schema;
        this.schemaLoaded = true;
        schemaManager.addSchema(schema);
        registerSchemaClasses(schema, SchemaTypeRegistry.getInstance());
    }

    protected function unmarshallXml(xml:XML, startNode:String, clazz:Class):Object {
        var qName:QName = new QName(schema.targetNamespace.uri, startNode);
        var decoder:XMLDecoder = new XMLDecoder();

        decoder.schemaManager = schemaManager;
        var obj:Object = decoder.decode(xml, qName);

        return obj;
    }

    protected function onSchemaLoadFault(e:FaultEvent):void {
        this.schema = null;
        this.schemaLoaded = false;
    }

    protected function registerSchemaClasses(schema:Schema, typeRegistry:SchemaTypeRegistry):void {
        AbstractClassEnforcer.enforceMethod("registerSchemaClasses");
    }


    protected function get isSchemaLoaded():Boolean
    {
        return schemaLoaded;
    }
}
}