page 50100 "Television Show Card"
{
    PageType = Card;
    SourceTable = "Television Show";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Synopsis; Synopsis)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("First Aired"; "First Aired")
                {
                    ApplicationArea = All;
                }
                field("Last Aired"; "Last Aired")
                {
                    ApplicationArea = All;
                }
                field("TVMaze ID"; "TVMaze ID")
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
            action(DownloadEpisodes)
            {
                Caption = 'Download Episode Information';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    DownloadEpisodes();
                end;
            }
        }
        area(Navigation)
        {
            action(TelevisionShowEpisodes)
            {
                Caption = 'Episodes';
                ApplicationArea = All;
                RunObject = page "Television Show Episodes";
                RunPageLink = "Television Show Code" = field (Code);
            }
        }
    }
}