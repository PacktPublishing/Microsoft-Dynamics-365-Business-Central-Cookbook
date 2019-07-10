codeunit 50112 "App Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        CurrentAppInfo: ModuleInfo;
    begin
        if NavApp.GetCurrentModuleInfo(CurrentAppInfo) then begin
            Case CurrentAppInfo.DataVersion() of
                Version.Create('1.0.0.0'):
                    PopulateTelevisionShowRunningField();
            end;
        end;
    end;

    local procedure PopulateTelevisionShowRunningField()
    var
        TelevisionShow: Record "Television Show";
    begin
        if TelevisionShow.FindSet() then
            repeat
                if TelevisionShow.Status = TelevisionShow.Status::Active then begin
                    TelevisionShow.Running := true;
                    TelevisionShow.Modify();
                end;
            until TelevisionShow.Next() = 0;
    end;
}