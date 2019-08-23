codeunit 50000 "Copy Transaction"
{
    procedure CopyTransaction()
    var
        CopyTransactionDialog: Page "Copy Transaction Dialog";
        FromSourceType: Option Transaction,"Posted Transaction";
        FromSourceEntryNo: Integer;
        ClearNewTransactionNo: Boolean;
        GetNewUnitCost: Boolean;
    begin
        if CopyTransactionDialog.RunModal() = Action::OK then begin
            CopyTransactionDialog.GetCopyTransactionParameters(FromSourceType, FromSourceEntryNo, ClearNewTransactionNo, GetNewUnitCost);
            DoCopyTransaction(FromSourceType, FromSourceEntryNo, ClearNewTransactionNo, GetNewUnitCost);
        end;
    end;

    local procedure DoCopyTransaction(var FromSourceType: Option Transaction,"Posted Transaction"; var FromSourceEntryNo: Integer; var ClearNewTransactionNo: Boolean; var GetNewUnitCost: Boolean)
    begin
        case FromSourceType of
            FromSourceType::Transaction:
                CopyFromTransaction(FromSourceEntryNo, ClearNewTransactionNo, GetNewUnitCost);
            FromSourceType::"Posted Transaction":
                CopyFromPostedTransaction(FromSourceEntryNo, ClearNewTransactionNo, GetNewUnitCost);
        end;
    end;

    local procedure CopyFromTransaction(var FromSourceEntryNo: Integer; var ClearNewTransactionNo: Boolean; var GetNewUnitCost: Boolean)
    var
        OldTransaction: Record "Transaction Entry";
        NewTransaction: Record "Transaction Entry";
    begin
        OldTransaction.Get(FromSourceEntryNo);

        NewTransaction.Init();

        NewTransaction.TransferFields(OldTransaction, false);

        if ClearNewTransactionNo then
            NewTransaction."Transaction No." := '';

        if GetNewUnitCost then
            NewTransaction.GetLastDirectUnitCost();

        NewTransaction.Insert(true);
    end;

    local procedure CopyFromPostedTransaction(var FromSourceEntryNo: Integer; var ClearNewTransactionNo: Boolean; var GetNewUnitCost: Boolean)
    var
        OldTransaction: Record "Posted Transaction Entry";
        NewTransaction: Record "Transaction Entry";
    begin
        OldTransaction.Get(FromSourceEntryNo);

        NewTransaction.Init();

        NewTransaction.TransferFields(OldTransaction, false);

        if ClearNewTransactionNo then
            NewTransaction."Transaction No." := '';

        if GetNewUnitCost then
            NewTransaction.GetLastDirectUnitCost();

        NewTransaction.Insert(true);
    end;
}