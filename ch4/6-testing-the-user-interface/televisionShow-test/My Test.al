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

    [Test]
    procedure TestPageTest()
    var
        TelevisionShow: Record "Television Show";
        TelevisionShowCard: TestPage "Television Show Card";
        LibraryUtility: Codeunit "Library - Utility";
        Assert: Codeunit Assert;
        NewShowCode: Code[20];
    begin
        //GIVEN: Television Show Card
        NewShowCode := LibraryUtility.GenerateRandomCode20(TelevisionShow.FieldNo(Code), Database::"Television Show");

        //WHEN: user opens Television Show card and creates new record
        TelevisionShowCard.OpenNew();
        TelevisionShowCard.Code.SetValue(NewShowCode);
        TelevisionShowCard.OK().Invoke();

        //THEN: the new record is successfully added to the table and exists once
        TelevisionShow.SetRange(Code, NewShowCode);
        Assert.RecordCount(TelevisionShow, 1);
    end;
}