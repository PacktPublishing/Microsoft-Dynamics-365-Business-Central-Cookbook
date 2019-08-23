pageextension 50001 pageextension50001 extends "Item Card"
{
    actions
    {
        modify(ItemsByLocation)
        {
            ApplicationArea = Invalid;
            Enabled = false;
            Visible = false;
        }
        addafter(ItemsByLocation)
        {
            action(CustomItemsByLocation)
            {
                ApplicationArea = Location;
                Caption = 'Items by Location';
                AccessByPermission = TableData Location = R;
                ToolTip = 'Show a list of items grouped by location.';
                Image = ItemAvailbyLoc;

                trigger OnAction()
                begin
                    PAGE.RUN(PAGE::"Custom Items by Location", Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        MESSAGE('Remember to verify all fields when creating new items.');
    end;
}

