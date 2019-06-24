pageextension 50000 CustomerCardExt extends "Customer Card"
{
    actions
    {
        addlast("F&unctions")
        {
            action("Call Azure Function")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message(CallAzureFunction());
                end;
            }
        }
    }

    local procedure CallAzureFunction(): Text
    var
        CallAzureFunction: Codeunit CallAzureFunction;
    begin
        exit(CallAzureFunction.CallAzureFunctionDemo(Rec.Name));
    end;
}