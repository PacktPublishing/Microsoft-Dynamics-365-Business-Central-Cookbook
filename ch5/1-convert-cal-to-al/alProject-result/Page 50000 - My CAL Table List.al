page 50000 "My CAL Table List"
{
    PageType = List;
    SourceTable = "My CAL Table";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                }
                field(Description;Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

