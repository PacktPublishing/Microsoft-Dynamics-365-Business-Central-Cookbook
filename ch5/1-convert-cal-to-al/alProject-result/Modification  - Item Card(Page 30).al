pageextension 50001 pageextension50001 extends "Item Card" 
{
    // version NAVW111.00.00.24742

    layout
    {
        addafter(Description)
        {
            field("My CAL Table Code";"My CAL Table Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SaveAsTemplate)
        {
            action(MyCalAction)
            {
                ApplicationArea = All;
                Caption = 'My CAL Action';

                trigger OnAction();
                begin
                    MESSAGE('You pressed the action.');
                end;
            }
        }
    }
}

