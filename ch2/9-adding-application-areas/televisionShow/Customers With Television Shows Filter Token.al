codeunit 50103 "Customers With Shows Filter"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::TextManagement, 'OnAfterMakeTextFilter', '', true, true)]
    local procedure OnAfterMakeTextFilter(var Position: Integer; var TextFilterText: Text)
    var
        Customer: Record Customer;
        CustomerTelevisionShows: Record "Customer Television Show";
        CustWithShowsTokenTxt: Label 'CUSTWITHSHOWS';
        MaxCount: Integer;
    begin
        if StrPos(UpperCase(CustWithShowsTokenTxt), UpperCase(TextFilterText)) = 0 then
            exit;

        MaxCount := 2000;
        TextFilterText := '';

        if Customer.FindSet() then begin
            repeat
                CustomerTelevisionShows.SetRange("Customer No.", Customer."No.");
                if not CustomerTelevisionShows.IsEmpty() then begin
                    MaxCount -= 1;

                    if TextFilterText <> '' then
                        TextFilterText += '|';

                    TextFilterText += Customer."No.";
                end;
            until (Customer.Next() = 0) or (MaxCount <= 0);
        end;
    end;
}