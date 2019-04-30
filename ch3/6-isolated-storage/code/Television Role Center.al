page 50103 "Television Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Activities; "Television RC Activities")
            {
                ApplicationArea = All;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = All;
            }
            part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action("Television Show List")
            {
                RunObject = page "Television Show List";
                Caption = 'Television Shows';
                ApplicationArea = All;
            }
            action("Customer List")
            {
                RunObject = page "Customer List";
                Caption = 'Customers';
                ApplicationArea = All;
            }
        }
        area(Processing)
        {
            group(New)
            {
                action(NewCustomer)
                {
                    RunPageMode = Create;
                    Caption = 'Customer';
                    RunObject = page "Customer Card";
                    Image = Customer;
                    ApplicationArea = All;
                }
            }
            group(Reports)
            {
                action("Television Show Report")
                {
                    Caption = 'Television Shows';
                    Image = Report;
                    RunObject = report "Television Shows Report";
                    ApplicationArea = All;
                }
            }
        }
    }
}