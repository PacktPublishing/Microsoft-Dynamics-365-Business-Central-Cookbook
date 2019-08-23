pageextension 50010 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Level Code"; "Level Code")
            {
                ApplicationArea = All;
            }
            field(Classification; Classification)
            {
                ApplicationArea = All;
            }
        }
    }
}