page 50100 "Parent Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;

    actions
    {
        area(Processing)
        {
            action("Read From Child Table")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ReadFromChildTable();
                end;
            }
        }
    }

    local procedure ReadFromChildTable()
    var
        ChildTable: Record "Child Table";
    begin
        if ChildTable.FindSet() then;
    end;
}