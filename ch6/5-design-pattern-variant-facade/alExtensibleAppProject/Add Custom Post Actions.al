codeunit 50003 "Add Custom Post Actions"
{
    [EventSubscriber(ObjectType::Table, Database::"Post Transaction Action", 'OnAddPostTransactionAction', '', false, false)]
    local procedure OnAddPostTransactionAction(var TempPostTransactionAction: Record "Post Transaction Action")
    begin
        AddCustomPostTransactionActions(TempPostTransactionAction);
    end;

    local procedure AddCustomPostTransactionActions(var TempPostTransactionAction: Record "Post Transaction Action")
    var
        Action1Code: Label 'ACTION1';
        Action1Desc: Label 'Action 1';
        Action2Code: Label 'ACTION2';
        Action2Desc: Label 'Action 2';
    begin
        if not TempPostTransactionAction.Get(Action1Code) then begin
            TempPostTransactionAction.Init();
            TempPostTransactionAction.Code := Action1Code;
            TempPostTransactionAction.Description := Action1Desc;
            TempPostTransactionAction."Codeunit No." := 0;
            TempPostTransactionAction.Insert();
        end;
        if not TempPostTransactionAction.Get(Action2Code) then begin
            TempPostTransactionAction.Init();
            TempPostTransactionAction.Code := Action2Code;
            TempPostTransactionAction.Description := Action2Desc;
            TempPostTransactionAction."Codeunit No." := 0;
            TempPostTransactionAction.Insert();
        end;
    end;
}