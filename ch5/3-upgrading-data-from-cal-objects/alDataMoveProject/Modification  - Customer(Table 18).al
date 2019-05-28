tableextension 50010 tableextension50010 extends Customer
{
    fields
    {
        field(50010; "Level Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Customer Level";
        }
        field(50011; Classification; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Classification;
        }
    }
}

