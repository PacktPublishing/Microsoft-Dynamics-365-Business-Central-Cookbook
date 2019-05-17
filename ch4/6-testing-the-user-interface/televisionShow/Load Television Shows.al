codeunit 50107 "Load Television Shows"
{
    var
        LoadedShows: Boolean;

    procedure LoadTelevisionShows(LoadGenre1: Boolean; LoadGenre2: Boolean; LoadGenre3: Boolean)
    begin
        LoadedShows := false;

        if LoadGenre1 then
            LoadGenre1Shows();

        if LoadGenre2 then
            LoadGenre2Shows();

        if LoadGenre3 then
            LoadGenre3Shows();

        if LoadedShows then
            UpdateTelevisionShowSetupToFinished();
    end;

    local procedure UpdateTelevisionShowSetupToFinished()
    var
        TelevisionShowSetup: Record "Television Show Setup";
    begin
        TelevisionShowSetup."Finished Assisted Setup" := true;
        TelevisionShowSetup.Modify();
    end;

    local procedure LoadGenre1Shows()
    begin
        TryInsertTelevisionShow('TV1000', 'Seinfeld');
        TryInsertTelevisionShow('TV1001', 'Friends');
        TryInsertTelevisionShow('TV1002', 'The Simpsons');
        TryInsertTelevisionShow('TV1003', 'The Big Bang Theory');
        TryInsertTelevisionShow('TV1004', 'The Office');
    end;

    local procedure LoadGenre2Shows()
    begin
        TryInsertTelevisionShow('TV2000', 'The Wire');
        TryInsertTelevisionShow('TV2001', 'The Sopranos');
        TryInsertTelevisionShow('TV2002', 'Mad Men');
        TryInsertTelevisionShow('TV2003', 'Deadwood');
        TryInsertTelevisionShow('TV2004', 'Breaking Bad');
    end;

    local procedure LoadGenre3Shows()
    begin
        TryInsertTelevisionShow('TV3000', 'Full House');
        TryInsertTelevisionShow('TV3001', 'The Andy Griffith Show');
        TryInsertTelevisionShow('TV3002', 'The Wonder Years');
        TryInsertTelevisionShow('TV3003', 'Peppa Pig');
        TryInsertTelevisionShow('TV3004', 'Looney Toons');
    end;

    local procedure TryInsertTelevisionShow(NewCode: Code[20]; NewName: Text[80])
    var
        TelevisionShow: Record "Television Show";
    begin
        TelevisionShow.Init();
        TelevisionShow.Code := NewCode;
        TelevisionShow.Name := NewName;
        if TelevisionShow.Insert() then
            LoadedShows := true;
    end;
}