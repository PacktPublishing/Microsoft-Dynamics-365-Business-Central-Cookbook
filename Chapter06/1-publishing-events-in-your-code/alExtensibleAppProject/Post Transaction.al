codeunit 50002 "Post Transaction"
{
    TableNo = "Transaction Entry";

    trigger OnRun()
    begin
        ErrorIfNoEntriesToPost(rec);
        PostTransactions(Rec);
        ShowSuccessMessage();
    end;

    local procedure PostTransactions(var TransactionEntry: Record "Transaction Entry")
    begin
        if TransactionEntry.FindSet() then begin
            repeat
                VerifyTransactionEntry(TransactionEntry);
                PostTransactionEntry(TransactionEntry);
            until TransactionEntry.Next() = 0;

            TransactionEntry.DeleteAll();
        end;
    end;

    local procedure VerifyTransactionEntry(var TransactionEntry: Record "Transaction Entry")
    begin
        with TransactionEntry do begin
            TestField("Transaction No.");
            TestField("Item No.");
            TestField(Quantity);
            TestField("Unit Cost");
            TestField("Suggested Unit Price");
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

    [IntegrationEvent(false, false)]
    local procedure OnAfterVerifyTransactionEntry(var TransactionEntry: Record "Transaction Entry")
    begin
    end;
}