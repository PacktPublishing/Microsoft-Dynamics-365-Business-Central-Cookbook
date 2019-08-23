page 50010 Classifications
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Classification;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}