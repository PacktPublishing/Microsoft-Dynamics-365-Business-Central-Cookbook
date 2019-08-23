codeunit 50002 "Post Transaction"
{
    TableNo = "Transaction Entry";

    trigger OnRun()
    begin
        ErrorIfNoEntriesToPost(rec);
        PostTransactions(Rec);
        DeletePostedTransactions(Rec);
        ShowSuccessMessage();
    end;

    local procedure PostTransactions(var TransactionEntry: Record "Transaction Entry")
    begin
        if TransactionEntry.FindSet() then begin
            repeat
                VerifyTransactionEntry(TransactionEntry);
                PostTransactionEntry(TransactionEntry);
                DoTransactionReasonCodeunitExecution(TransactionEntry);
            until TransactionEntry.Next() = 0;
        end;
    end;

    local procedure DeletePostedTransactions(var TransactionEntry: Record "Transaction Entry")
    begin
        TransactionEntry.DeleteAll();
    end;

    local procedure VerifyTransactionEntry(var TransactionEntry: Record "Transaction Entry")
    begin
        with TransactionEntry do begin
            TestField("Transaction No.");
            TestField("Item No.");
            TestField(Quantity);
            TestField("Unit Cost");
            TestField("Suggested Unit Price");
            TestField(Status, Status::Verified);
        end;
        OnAfterVerifyTransactionEntry(TransactionEntry);
    end;

    local procedure PostTransactionEntry(var TransactionEntry: Record "Transaction Entry")
    var
        PostedTransactionEntry: Record "Posted Transaction Entry";
    begin
        PostedTransactionEntry.Init();
        PostedTransactionEntry.TransferFields(TransactionEntry);
        PostedTransactionEntry.Insert(true);
    end;

    local procedure ErrorIfNoEntriesToPost(var TransactionEntry: Record "Transaction Entry")
    var
        NoEntriesErr: Label 'There are no entries to post.';
    begin
        if TransactionEntry.IsEmpty() then
            Error(NoEntriesErr);
    end;

    local procedure ShowSuccessMessage()
    var
        EntriesPostedMsg: Label 'The entries have been posted.';
    begin
        if GuiAllowed then
            Message(EntriesPostedMsg);
    end;

    local procedure DoTransactionReasonCodeunitExecution(var TransactionEntry: Record "Transaction Entry")
    var
        HandlePostTransactionAction: Codeunit "Handle Post Transaction Action";
    begin
        if TransactionEntry."Post Transaction Action" = '' then
            exit;

        HandlePostTransactionAction.Run(TransactionEntry);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterVerifyTransactionEntry(var TransactionEntry: Record "Transaction Entry")
    begin
    end;
}