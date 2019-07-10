codeunit 50101 SalesPostSubscribers
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure OnAfterConfirmPost(SalesHeader: Record "Sales Header")
    var
        CheckCustomerTelevisionShows: Codeunit "Check Cust. Television Shows";
    begin
        CheckCustomerTelevisionShows.CheckCustomerTelevisionShows(SalesHeader."Sell-to Customer No.");
    end;
}