page 50108 "License Input Dialog"
{
    PageType = StandardDialog;
    InstructionalText = 'Enter the license text';

    layout
    {
        area(Content)
        {
            field(LicenseText; LicenseText)
            {
                Caption = 'Enter license:';
                ApplicationArea = All;
            }
        }
    }

    var
        LicenseText: Text[10];

    procedure GetLicenseText(): Text
    begin
        exit(LicenseText);
    end;
}