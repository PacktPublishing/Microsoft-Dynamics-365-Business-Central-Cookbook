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
        TryInsertTelevisionShow('TV1000', 'Seinfeld', 530);
        TryInsertTelevisionShow('TV1001', 'Friends', 431);
        TryInsertTelevisionShow('TV1002', 'The Simpsons', 83);
        TryInsertTelevisionShow('TV1003', 'The Big Bang Theory', 66);
        TryInsertTelevisionShow('TV1004', 'The Office', 526);
    end;

    local procedure LoadGenre2Shows()
    begin
        TryInsertTelevisionShow('TV2000', 'The Wire', 179);
        TryInsertTelevisionShow('TV2001', 'The Sopranos', 527);
        TryInsertTelevisionShow('TV2002', 'Mad Men', 385);
        TryInsertTelevisionShow('TV2003', 'Deadwood', 565);
        TryInsertTelevisionShow('TV2004', 'Breaking Bad', 169);
    end;

    local procedure LoadGenre3Shows()
    begin
        TryInsertTelevisionShow('TV3000', 'Full House', 1251);
        TryInsertTelevisionShow('TV3001', 'The Andy Griffith Show', 3853);
        TryInsertTelevisionShow('TV3002', 'The Wonder Years', 1294);
        TryInsertTelevisionShow('TV3003', 'Peppa Pig', 4972);
        TryInsertTelevisionShow('TV3004', 'Looney Toons', 4533);
    end;

    local procedure TryInsertTelevisionShow(NewCode: Code[20]; NewName: Text[80]; TVMazeId: Integer)
    var
        TelevisionShow: Record "Television Show";
    begin
        if not TelevisionShow.Get(NewCode) then begin
            TelevisionShow.Init();
            TelevisionShow.Code := NewCode;
            TelevisionShow.Insert();
            LoadedShows := true;
        end;

        TelevisionShow.Name := NewName;
        TelevisionShow."TVMaze ID" := TVMazeId;

        TelevisionShow.Modify();
    end;
}