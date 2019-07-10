codeunit 50111 "App Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InstallTelevisionSetup();
        EnableApplicationArea();
        InstallSampleTelevisionShows();
    end;

    local procedure EnableApplicationArea()
    var
        EnableTvApplciationArea: Codeunit "Enable TV Application Area";
    begin
        if not EnableTvApplciationArea.IsTelevisionShowsEnabled() then
            EnableTvApplciationArea.EnableTelevisionShows();
    end;

    local procedure InstallTelevisionSetup()
    var
        TelevisionSetup: Record "Television Show Setup";
    begin
        if not TelevisionSetup.IsEmpty then
            exit;
        TelevisionSetup.Init();
        TelevisionSetup.Insert(true);
    end;

    local procedure InstallSampleTelevisionShows()
    var
        LoadTvShows: Codeunit "Load Television Shows";
    begin
        LoadTvShows.LoadTelevisionShows(true, true, true);
    end;
}