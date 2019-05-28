table 50011 "Customer Level"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2;Description;Text[80])
        {
            DataClassification = CustomerContent;
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

