package com.sysbliss.xml.xsd.util
{
import flash.utils.describeType;
import flash.utils.getDefinitionByName;

public class TypeUtils
{
    public function TypeUtils()
    {
    }

    public static function isAccessorIterable(obj:*, accessor:String):Boolean
    {
        var contentType:XML = describeType(obj);
        var contentTypeField:XML = contentType..accessor.(attribute('name') == accessor)[0];
        var isIterable:Boolean = false;

        if(contentTypeField != null) {
          var fieldType:XML = describeType(getDefinitionByName(contentTypeField.@type.toString()));

          var isIList:Boolean = (fieldType.factory.implementsInterface.(attribute('type') == "mx.collections::IList") != null);
          var isXMLList:Boolean = (fieldType.@name == "XMLList");
          var isArray:Boolean = (fieldType.@name == "Array");

          isIterable = (isIList || isXMLList || isArray);
            
        }
           return isIterable;
    }

    public static function isArray(obj:*, accessor:String):Boolean
    {
        var contentType:XML = describeType(obj);
        var contentTypeField:XML = contentType..accessor.(attribute('name') == accessor)[0];
        var isArray:Boolean = false;

        if(contentTypeField != null) {
          var fieldType:XML = describeType(getDefinitionByName(contentTypeField.@type.toString()));

          isArray = (fieldType.@name == "Array");
        }
           return isArray;
    }

    public static function isArrayCollection(obj:*, accessor:String):Boolean
    {
        var contentType:XML = describeType(obj);
        var contentTypeField:XML = contentType..accessor.(attribute('name') == accessor)[0];
        var isArrayCollection:Boolean = false;

        if(contentTypeField != null) {
          var fieldType:XML = describeType(getDefinitionByName(contentTypeField.@type.toString()));

          isArrayCollection = (fieldType.@name == "mx.collections::ArrayCollection");
        }
           return isArrayCollection;
    }

    public static function isXMLList(obj:*, accessor:String):Boolean
    {
        var contentType:XML = describeType(obj);
        var contentTypeField:XML = contentType..accessor.(attribute('name') == accessor)[0];
        var isXMLList:Boolean = false;

        if(contentTypeField != null) {
          var fieldType:XML = describeType(getDefinitionByName(contentTypeField.@type.toString()));

          isXMLList = (fieldType.@name == "XMLList");
        }
           return isXMLList;
    }
}
}
