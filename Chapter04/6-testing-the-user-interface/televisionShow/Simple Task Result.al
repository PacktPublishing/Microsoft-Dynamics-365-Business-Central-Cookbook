table 50104 "Simple Task Result"
{
    fields
    {
        field(1; "Primary Key"; Code[1])
        {

        }
        field(2; "DateTime Task Last Ran"; DateTime)
        {

        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure UpdateWithNewRun()
    begin
        if not Get() then
            Insert();

        "DateTime Task Last Ran" := CurrentDateTime();
        Modify();
    end;
}