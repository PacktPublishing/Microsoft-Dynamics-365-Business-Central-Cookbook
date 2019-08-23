table 50001 "Post Transaction Action"
{
    LookupPageId = "Post Transaction Actions";

    fields
    {
        field(1; Code; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Codeunit No."; Integer)
        {
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    [IntegrationEvent(false, false)]
    procedure OnAddPostTransactionAction(var TempPostTransactionAction: Record "Post Transaction Action" temporary)
    begin
    end;
}