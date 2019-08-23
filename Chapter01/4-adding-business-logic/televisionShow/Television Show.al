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
            trigger onValidate()
            begin
                VerifyDates();
            end;
        }
        field(6; "Last Aired"; Date)
        {
            trigger onValidate()
            begin
                VerifyDates();
            end;
        }
        field(7; "Created By"; Code[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId();
    end;

    local procedure VerifyDates()
    var
        FirstAiredDateCannotBeLaterErr: Label '%1 cannot be earlier than %2';
    begin
        if "Last Aired" = 0D then
            exit;

        if "First Aired" > "Last Aired" then
            Error(FirstAiredDateCannotBeLaterErr,
                    FieldCaption("Last Aired"),
                    FieldCaption("First Aired"));
    end;
}