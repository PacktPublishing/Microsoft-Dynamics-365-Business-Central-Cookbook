table 50000 "My CAL Table"
{
    LookupPageID = "My CAL Table List";

    fields
    {
        field(1;"Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

