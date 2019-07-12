codeunit 50000 "Copy Transaction"
{
    procedure CopyTransaction()
    var
        CopyTransactionDialog: Page "Copy Transaction Dialog";
        FromRecordVariant: Variant;
        TempCopyTransactionArgument: Record "Copy Transaction Argument" temporary;
    begin
        if CopyTransactionDialog.RunModal() = Action::OK then begin
            CopyTransactionDialog.GetCopyTransactionParameters(FromRecordVariant, TempCopyTransactionArgument);
            DoCopyTransaction(FromRecordVariant, TempCopyTransactionArgument);
        end;
    end;

    local procedure DoCopyTransaction(var FromRecordVariant: Variant; var TempCopyTransactionArgument: Record "Copy Transaction Argument" temporary)
    var
        FromRecordRef: RecordRef;
        DataTypeMgmt: Codeunit "Data Type Management";
    begin
        DataTypeMgmt.GetRecordRef(FromRecordVariant, FromRecordRef);
        CopyFromSourceRecord(FromRecordRef, TempCopyTransactionArgument);
    end;

    local procedure CopyFromSourceRecord(var FromRecordRef: RecordRef; var TempCopyTransactionArgument: Record "Copy Transaction Argument" temporary)
    var
        FromTransactionEntry: Record "Transaction Entry";
        FromPostedTransactionEntry: Record "Posted Transaction Entry";
        NewTransaction: Record "Transaction Entry";
    begin
        NewTransaction.Init();
        case FromRecordRef.Number() of
            Database::"Transaction Entry":
                begin
                    FromRecordRef.SetTable(FromTransactionEntry);
                    NewTransaction.TransferFields(FromTransactionEntry, false);
                end;
            Database::"Posted Transaction Entry":
                begin
                    FromRecordRef.SetTable(FromPostedTransactionEntry);
                    NewTransaction.TransferFields(FromPostedTransactionEntry, false);
                end;
        end;
        if TempCopyTransactionArgument."Reset Transaction No." then
            NewTransaction."Transaction No." := '';
        if TempCopyTransactionArgument."Get Updated Unit Cost" then
            NewTransaction.GetLastDirectUnitCost();
        NewTransaction.Status := NewTransaction.Status::New;
        OnBeforeInsertNewTransactionEntry(NewTransaction, TempCopyTransactionArgument);
        NewTransaction.Insert(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertNewTransactionEntry(var NewTransaction: Record "Transaction Entry"; var TempCopyTransactionArgument: Record "Copy Transaction Argument" temporary)
    begin
    end;
}