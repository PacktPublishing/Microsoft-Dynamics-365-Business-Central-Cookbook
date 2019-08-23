codeunit 50151 "My Test Library"
{
    procedure CreateTelevisionShow(var TelevisionShow: Record "Television Show")
    var
        LibraryUtility: Codeunit "Library - Utility";
    begin
        CLEAR(TelevisionShow);
        TelevisionShow.Validate(Code,
           LibraryUtility.GenerateRandomCode20(TelevisionShow.FieldNo(Code), Database::"Television Show"));
        TelevisionShow.VALIDATE(Name, TelevisionShow.Code);
        TelevisionShow.MODIFY(TRUE);
    end;

    procedure CreateTelevisionShowCode(): Code[20]
    var
        TelevisionShow: Record "Television Show";
    begin
        CreateTelevisionShow(TelevisionShow);
        exit(TelevisionShow.Code);
    end;

    procedure DeleteTelevisionShow(TelevisionShowCode: Code[20])
    var
        TelevisionShow: Record "Television Show";
    begin
        TelevisionShow.Get(TelevisionShowCode);
        TelevisionShow.Delete(true);
    end;
}