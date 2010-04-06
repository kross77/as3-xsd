package com.sysbliss.xml.xsd.model
{
public class ChoiceHolder
{
    public var TypeWithId:TypeWithIdType;
    public var TypeWithName:TypeWithNameType;
    public var TypeWithDesc:TypeWithDescType;

    public function ChoiceHolder()
    {
    }

    public function isId():Boolean {
        return (TypeWithId != null);
    }

    public function isName():Boolean {
        return (TypeWithName != null);
    }

    public function isDesc():Boolean {
        return (TypeWithDesc != null);
    }
}
}