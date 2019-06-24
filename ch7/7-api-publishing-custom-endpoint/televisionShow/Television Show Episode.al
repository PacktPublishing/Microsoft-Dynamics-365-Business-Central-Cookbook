table 50105 "Television Show Episode"
{
    fields
    {
        field(1; "Television Show Code"; Code[20])
        {
            TableRelation = "Television Show";
        }
        field(2; "Episode ID"; Integer)
        {
        }
        field(3; Name; Text[100])
        {
        }
        field(4; "Season No."; Integer)
        {
        }
        field(5; "Episode No."; Integer)
        {
        }
        field(6; "Air Date"; Date)
        {
        }
        field(7; Summary; Text[250])
        {
        }
    }

    keys
    {
        key(PK; "Television Show Code", "Episode ID")
        {
            Clustered = true;
        }
    }
}