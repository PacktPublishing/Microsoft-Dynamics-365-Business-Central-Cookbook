codeunit 50000 "Copy Transaction"
{
    procedure CopyTransaction()
    var
        CopyTransactionDialog: Page "Copy Transaction Dialog";
        ClearNewTransactionNo: Boolean;
        GetNewUnitCost: Boolean;
        FromRecordVariant: Variant;
    begin
        if CopyTransactionDialog.RunModal() = Action::OK then begin
            CopyTransactionDialog.GetCopyTransactionParameters(FromRecordVariant, ClearNewTransactionNo, GetNewUnitCost);
            DoCopyTransaction(FromRecordVariant, ClearNewTransactionNo, GetNewUnitCost);
        end;
    end;

    local procedure DoCopyTransaction(var FromRecordVariant: Variant; var ClearNewTransactionNo: Boolean; var GetNewUnitCost: Boolean)
    var
        FromRecordRef: RecordRef;
        DataTypeMgmt: Codeunit "Data Type Management";
    begin
        DataTypeMgmt.GetRecordRef(FromRecordVariant, FromRecordRef);
        CopyFromSourceRecord(FromRecordRef, ClearNewTransactionNo, GetNewUnitCost);
    end;

    local procedure CopyFromSourceRecord(var FromRecordRef: RecordRef; var ClearNewTransactionNo: Boolean; var GetNewUnitCost: Boolean)
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
        if ClearNewTransactionNo then
            NewTransaction."Transaction No." := '';
        if GetNewUnitCost then
            NewTransaction.GetLastDirectUnitCost();
        NewTransaction.Status := NewTransaction.Status::New;
        NewTransaction.Insert(true);
    end;
}