codeunit 50000 "Item Table Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterCheckDocuments', '', False, False)]
    local procedure OnAfterCheckDocuments(var Item: Record Item; var CurrentFieldNo: Integer)
    begin
        Item.DoCustomDocumentCheck(CurrentFieldNo);
    end;
}