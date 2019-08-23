page 50150 "UI Handler Test"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;

    actions
    {
        area(Processing)
        {
            action(ConfirmTest)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ConfirmQst: Label 'Test confirmation';
                begin
                    if Confirm(ConfirmQst, false) then;
                end;
            }
        }
    }
}