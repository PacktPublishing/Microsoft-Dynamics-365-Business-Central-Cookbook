page 50112 "Televison Show API"
{
    PageType = API;
    Caption = 'tvshows';
    APIPublisher = 'mypublisher';
    APIGroup = 'tvshowproject';
    APIVersion = 'v1.0';
    EntityName = 'televisionshow';
    EntitySetName = 'televisionshows';
    SourceTable = "Television Show";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(Synopsis; Synopsis)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}