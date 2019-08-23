codeunit 50001 "Handle Post Transaction Action"
{
    TableNo = "Transaction Entry";

    trigger OnRun()
    begin
        if Rec."Post Transaction Action" <> '' then
            RunPostTransactionCodeunit(Rec);
    end;

    local procedure RunPostTransactionCodeunit(var TransactionEntry: Record "Transaction Entry")
    var
        PostTransactionAction: Record "Post Transaction Action";
    begin
        PostTransactionAction.Get(TransactionEntry."Post Transaction Action");

        if PostTransactionAction."Codeunit No." <> 0 then
            Codeunit.Run(PostTransactionAction."Codeunit No.", TransactionEntry);
    end;
}