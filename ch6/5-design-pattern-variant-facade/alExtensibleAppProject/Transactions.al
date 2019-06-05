page 50003 "Transaction List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Editable = false;
    SourceTable = "Transaction Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Suggested Unit Price"; "Suggested Unit Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}