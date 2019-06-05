page 50001 "Copy Transaction Dialog"
{
    PageType = StandardDialog;
    Caption = 'Copy Transaction';
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(FromType; FromType)
                {
                    Caption = 'Copy From';
                    ApplicationArea = All;
                }
                field(FromTransactionEntryNo; FromTransactionEntryNo)
                {
                    Caption = 'Transaction Entry No.';
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupTransactionEntryNo();
                    end;

                    trigger OnValidate()
                    begin
                        ValidateTransactionEntryNo();
                    end;
                }
                field(GetUpdatedUnitCost; GetUpdatedUnitCost)
                {
                    Caption = 'Get Updated Unit Cost';
                    ApplicationArea = All;
                }
                field(ClearTransactionNo; ResetNewTransactionNo)
                {
                    Caption = 'Reset Transaction No.';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        FromType: Option Transaction,"Posted Transaction";
        ResetNewTransactionNo: Boolean;
        GetUpdatedUnitCost: Boolean;
        FromTransactionEntryNo: Integer;

    local procedure LookupTransactionEntryNo()
    var
        FromTransaction: Record "Transaction Entry";
        FromPostedTransaction: Record "Posted Transaction Entry";
    begin
        case FromType of
            FromType::Transaction:
                if Page.RunModal(0, FromTransaction) = Action::LookupOK then
                    FromTransactionEntryNo := FromTransaction."Entry No.";
            FromType::"Posted Transaction":
                if Page.RunModal(0, FromPostedTransaction) = Action::LookupOK then
                    FromTransactionEntryNo := FromPostedTransaction."Entry No.";
        end;
    end;

    local procedure ValidateTransactionEntryNo();
    var
        FromTransaction: Record "Transaction Entry";
        FromPostedTransaction: Record "Posted Transaction Entry";
    begin
        if FromTransactionEntryNo <> 0 then
            CASE FromType OF
                FromType::Transaction:
                    FromTransaction.GET(FromTransactionEntryNo);
                FromType::"Posted Transaction":
                    FromPostedTransaction.GET(FromTransactionEntryNo);
            END;
    end;

    procedure GetCopyTransactionParameters(var FromRecordVariant: Variant; var ClearNewTransactionNo: Boolean; var GetNewUnitCost: Boolean)
    begin
        SetFromRecordVariant(FromRecordVariant);
        ClearNewTransactionNo := ResetNewTransactionNo;
        GetNewUnitCost := GetUpdatedUnitCost;
    end;

    local procedure SetFromRecordVariant(var FromRecordVariant: Variant)
    var
        FromTransactionEntry: Record "Transaction Entry";
        FromPostedTransactionEntry: Record "Posted Transaction Entry";
    begin
        case FromType of
            FromType::Transaction:
                begin
                    FromTransactionEntry.Get(FromTransactionEntryNo);
                    FromRecordVariant := FromTransactionEntry;
                end;
            FromType::"Posted Transaction":
                begin
                    FromPostedTransactionEntry.Get(FromTransactionEntryNo);
                    FromRecordVariant := FromPostedTransactionEntry;
                end;
        end;
    end;
}