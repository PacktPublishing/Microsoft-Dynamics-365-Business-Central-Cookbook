table 50125 "Child Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}