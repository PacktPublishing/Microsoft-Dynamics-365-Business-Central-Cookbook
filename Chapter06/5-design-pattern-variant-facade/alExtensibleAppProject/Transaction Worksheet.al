page 50000 "Transaction Worksheet"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
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
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Post Transaction Action"; "Post Transaction Action")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Copy Transaction")
            {
                ApplicationArea = All;
                Image = Copy;

                trigger OnAction();
                var
                    CopyTransaction: Codeunit "Copy Transaction";
                begin
                    CopyTransaction.CopyTransaction();
                end;
            }
            action("Post Entries")
            {
                ApplicationArea = All;
                Image = PostDocument;

                trigger OnAction();
                var
                    PostTransaction: Codeunit "Post Transaction";
                begin
                    PostTransaction.Run(rec);
                end;
            }
        }
        area(Navigation)
        {
            action("Posted Transactions")
            {
                ApplicationArea = All;
                Image = LedgerEntries;
                RunObject = page "Posted Transactions";
            }
        }
    }
}