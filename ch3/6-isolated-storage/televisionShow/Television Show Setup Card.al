page 50106 "Television Show Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Television Show Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(SetLicense)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    LicenseInputDialog: page "License Input Dialog";
                begin
                    if LicenseInputDialog.RunModal() = Action::OK then
                        SetLicenseInStorage(LicenseInputDialog.GetLicenseText());
                end;
            }
            action(GetLicense)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GetLicenseFromStorage();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;

    local procedure SetLicenseInStorage(LicenseText: Text[10])
    var
        SuccessMsg: Label 'License successfully stored';
        FailureErr: Label 'License could not be stored';
        MustNotBeBlankErr: Label 'You must provide a valid license';
    begin
        if LicenseText <> '' then begin
            DeleteExistingLicense();
            if IsolatedStorage.Set(GetLicenseStorageKey(), LicenseText, DataScope::Module) then
                Message(SuccessMsg)
            else
                Error(FailureErr);
        end else
            Error(MustNotBeBlankErr);
    end;

    local procedure GetLicenseFromStorage()
    var
        SuccessMsg: Label 'License retrieved: %1';
        FailureErr: Label 'License could not be retrieved';
        LicenseText: Text;
    begin
        if IsolatedStorage.Get(GetLicenseStorageKey(), DataScope::Module, LicenseText) then
            Message(SuccessMsg, LicenseText)
        else
            Error(FailureErr);
    end;

    local procedure DeleteExistingLicense()
    var
        PromptToDeleteMsg: Label 'There is an existing license stored. Are you sure you want to replace it?';
    begin
        if IsolatedStorage.Contains(GetLicenseStorageKey(), DataScope::Module) then
            if Confirm(PromptToDeleteMsg, false) then
                IsolatedStorage.Delete(GetLicenseStorageKey(), DataScope::Module);
    end;

    local procedure GetLicenseStorageKey(): Text
    var
        LicenseStorageKey: Label 'LIC';
    begin
        exit(LicenseStorageKey);
    end;
}