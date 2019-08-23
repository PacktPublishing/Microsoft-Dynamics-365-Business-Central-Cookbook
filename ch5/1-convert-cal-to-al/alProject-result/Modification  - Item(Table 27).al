tableextension 50002 tableextension50002 extends Item 
{
    // version NAVW111.00.00.27667

    fields
    {
        field(50000;"My CAL Table Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "My CAL Table".Code;
        }
    }
}

