page 50111 "Television Show Episodes"
{
    PageType = List;
    Caption = 'Episodes';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Television Show Episode";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Season No."; "Season No.")
                {
                    ApplicationArea = All;
                }
                field("Episode No."; "Episode No.")
                {
                    ApplicationArea = All;
                }
                field("Air Date"; "Air Date")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Summary; Summary)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}