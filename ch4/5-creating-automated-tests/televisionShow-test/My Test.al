codeunit 50150 "My Test"
{
    Subtype = Test;

    [Test]
    procedure SuccessTest()
    var
        TelevisionShow: Record "Television Show";
        LibraryUtility: Codeunit "Library - Utility";
    begin
        TelevisionShow.Init();

        TelevisionShow.Validate(Code,
           LibraryUtility.GenerateRandomCode20(TelevisionShow.FieldNo(Code), Database::"Television Show"));

        TelevisionShow.Insert(true);
    end;

    [Test]
    procedure FailureTest()
    var
        TelevisionShow: Record "Television Show";
        LibraryUtility: Codeunit "Library - Utility";
    begin
        TelevisionShow.Get(LibraryUtility.GenerateRandomCode20(TelevisionShow.FieldNo(Code), Database::"Television Show"));
    end;
}