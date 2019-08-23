page 50104 "Television RC Activities"
{
    Caption = 'Television Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Television Cue";
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            cuegroup("Television Shows")
            {
                CuegroupLayout = Wide;
                field(Active; Active)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Television Show List";
                }
                field(Finished; Finished)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Television Show List";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        If not Get() then begin
            Init();
            Insert();
        end;

    end;
}