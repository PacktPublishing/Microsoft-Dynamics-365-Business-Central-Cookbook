codeunit 50108 "Customer Card Notification"
{
    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure OnAfterGetRecordEvent(var Rec: Record Customer)
    begin
        HandleCustomerCardNotification(Rec."No.");
    end;

    local procedure HandleCustomerCardNotification(CustomerNo: Code[20])
    begin
        if CustomerNo = '' then
            exit;

        if not HasTelevisionEntries(CustomerNo) then
            ShowCustomerCardNotification(CustomerNo);
    end;

    local procedure HasTelevisionEntries(CustomerNo: Code[20]): Boolean
    var
        CustomerTelevisionShow: Record "Customer Television Show";
    begin
        CustomerTelevisionShow.SetRange("Customer No.", CustomerNo);
        exit(not CustomerTelevisionShow.IsEmpty());
    end;

    local procedure ShowCustomerCardNotification(CustomerNo: Code[20])
    var
        CustomerCardNotification: Notification;
        NotificationMsg: Label 'Customer %1 has no television shows. Do you want to set some up?';
        ActionYesTxt: Label 'Yes';
    begin
        CustomerCardNotification.Message := StrSubstNo(NotificationMsg, CustomerNo);
        CustomerCardNotification.Scope := NotificationScope::LocalScope;
        CustomerCardNotification.SetData('CustomerNo', CustomerNo);
        CustomerCardNotification.AddAction(ActionYesTxt, CODEUNIT::"Customer Card Notification", 'OpenCustomerTelevisionShows');
        CustomerCardNotification.Send();
    end;    

    procedure OpenCustomerTelevisionShows(CustomerCardNotification: Notification)
    var
        CustomerTelevisionShow: Record "Customer Television Show";
        CustomerTelevisionShows: Page "Customer Television Shows";
        CustomerNo: Code[20];
    begin
        CustomerNo := CustomerCardNotification.GetData('CustomerNo');
        CustomerTelevisionShow.SetRange("Customer No.", CustomerNo);
        CustomerTelevisionShows.SetTableView(CustomerTelevisionShow);
        CustomerTelevisionShows.Run();
    end;
}