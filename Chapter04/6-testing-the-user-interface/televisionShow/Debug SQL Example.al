page 50110 "Debug SQL Example"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;

    actions
    {
        area(Processing)
        {
            action("Find Records")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    FindRecords();
                end;
            }
        }
    }

    local procedure FindRecords()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        ItemLedgerEntry.FindSet();
        CustomerLedgerEntry.FindSet();
        VendLedgerEntry.FindSet();
    end;
}