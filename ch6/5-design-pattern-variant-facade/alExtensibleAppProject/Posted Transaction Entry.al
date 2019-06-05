table 50002 "Posted Transaction Entry"
{
    LookupPageId = "Posted Transactions";

    fields
    {
        field(1; "Entry No."; Integer)
        {
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
        }
        field(5; Description; Text[100])
        {
            Editable = false;
        }
        field(6; Quantity; Decimal)
        {
        }
        field(7; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
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
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}