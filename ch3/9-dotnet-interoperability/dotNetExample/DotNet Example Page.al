page 50145 "DotNet Example Page"
{
    PageType = ListPlus;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field(Number; Number)
                {
                    Caption = 'Enter the base number:';
                    ApplicationArea = All;
                }
                field(Power; Power)
                {
                    Caption = 'Enter the power to be applied:';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Calculate power';

                trigger OnAction()
                var
                    MessageTxt: Label '%1 to the power of %2 is %3';
                begin
                    Message(MessageTxt, Number, Power, CalculatePowerOfNumber(Number, Power));
                end;
            }
        }
    }

    var
        Number: Decimal;
        Power: Decimal;

    local procedure CalculatePowerOfNumber(Number: Decimal; Power: Decimal): Decimal
    var
        Math: DotNet MyMathLib;
    begin
        exit(Math.Pow(Number, Power));
    end;
}