pageextension 50100 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Television Viewing Country"; "Television Viewing Country")
            {
                ApplicationArea = All;
            }
        }
        addfirst(FactBoxes)
        {
            part("Television Control AddIn Fctbx"; "Television Control AddIn Fctbx")
            {
                Caption = 'Favorite Television Show';
                ApplicationArea = All;
                SubPageLink = "No." = field ("No.");
            }
        }
    }

    actions
    {
        addlast(Navigation)
        {
            action("Customer Television Shows")
            {
                ApplicationArea = All;
                Image = ListPage;
                RunObject = Page "Customer Television Shows";
                RunPageLink = "Customer No." = field ("No.");
            }
        }
    }
}