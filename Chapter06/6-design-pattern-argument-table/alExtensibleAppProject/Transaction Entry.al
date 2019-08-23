table 50000 "Transaction Entry"
{
    LookupPageId = "Transaction List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Transaction No."; Code[20])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                SetItemInformation();
                GetLastDirectUnitCost();
            end;
        }
        field(5; Description; Text[100])
        {
            Editable = false;
        }
        field(6; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                CalculateTotalCost();
            end;
        }
        field(7; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;

            trigger OnValidate()
            begin
                CalculateSuggestedUnitPrice();
                CalculateTotalCost();
            end;
        }
        field(8; "Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(9; "Suggested Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(10; Status; Enum "Transaction Status")
        {
        }
        field(11; "Post Transaction Action"; Code[20])
        {
            TableRelation = "Post Transaction Action";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    local procedure CalculateSuggestedUnitPrice()
    begin
        "Suggested Unit Price" := "Unit Cost" * 1.25;
    end;

    local procedure CalculateTotalCost()
    begin
        "Total Cost" := Quantity * "Unit Cost";
    end;

    local procedure SetItemInformation()
    var
        Item: Record Item;
    begin
        if not Item.Get("Item No.") then
            Clear(Description);

        Description := Item.Description;
    end;

    procedure GetLastDirectUnitCost()
    var
        PurchaseInvLine: Record "Purch. Inv. Line";
        IsHandled: Boolean;
    begin
        OnBeforeGetLastDirectUnitCost(Rec, IsHandled);
        if IsHandled then
            exit;
        clear("Unit Cost");

        if "Item No." = '' then
            exit;

        PurchaseInvLine.SetRange(Type, PurchaseInvLine.Type::Item);
        PurchaseInvLine.SetRange("No.", "Item No.");
        if PurchaseInvLine.FindLast() then
            validate("Unit Cost", PurchaseInvLine."Direct Unit Cost");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetLastDirectUnitCost(var TransactionEntry: Record "Transaction Entry"; var IsHandled: Boolean)
    begin
    end;
}