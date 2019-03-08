table 50100 "Television Show"
{ 
    fields
    {
        field(1; Code; Code[20])
        {
             NotBlank = true;
        }
        field(2; Name; Text[80])
        {
        }
        field(3; Synopsis; Text[250])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Active,Finished';
            OptionMembers = Active,Finished;
        }
        field(5; "First Aired"; Date)
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