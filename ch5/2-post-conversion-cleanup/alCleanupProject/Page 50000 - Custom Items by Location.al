page 50000 "Custom Items by Location"
{
    Caption = 'Items by Location';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPlus;
    SaveValues = true;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(ShowInTransit;ShowInTransit)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Show Items in Transit';
                    ToolTip = 'Specifies the items in transit between locations.';

                    trigger OnValidate()
                    begin
                        ShowInTransitOnAfterValidate;
                    end;
                }
                field(ShowColumnName;ShowColumnName)
                {
                    ApplicationArea = Location;
                    Caption = 'Show Column Name';
                    ToolTip = 'Specifies that the names of columns are shown in the matrix window.';

                    trigger OnValidate()
                    begin
                        ShowColumnNameOnAfterValidate;
                    end;
                }
                field(MATRIX_CaptionRange;MATRIX_CaptionRange)
                {
                    ApplicationArea = Location;
                    Caption = 'Column Set';
                    Editable = false;
                    ToolTip = 'Specifies the range of values that are displayed in the matrix window, for example, the total period. To change the contents of the field, choose Next Set or Previous Set.';
                }
            }
            part(MatrixForm;"Items by Location Matrix")
            {
                ApplicationArea = Location;
                ShowFilter = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Location;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    SetColumns(MATRIX_SetWanted::Previous);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Location;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    SetColumns(MATRIX_SetWanted::Next);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        TempMatrixLocation.GetLocationsIncludingUnspecifiedLocation(false,false);
    end;

    trigger OnOpenPage()
    begin
        SetColumns(MATRIX_SetWanted::Initial);
    end;

    var
        TempMatrixLocation: Record Location temporary;
        MatrixRecords: array [32] of Record Location;
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        ShowColumnName: Boolean;
        ShowInTransit: Boolean;
        MATRIX_CaptionSet: array [32] of Text[80];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[80];
        MATRIX_CurrSetLength: Integer;
        UnspecifiedLocationCodeTxt: Label 'UNSPECIFIED', Comment='Code for unspecified location';

    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next)
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        TempMatrixLocation.SETRANGE("Use As In-Transit",ShowInTransit);

        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GETTABLE(TempMatrixLocation);
        MatrixRecordRef.SETTABLE(TempMatrixLocation);

        if ShowColumnName then
          CaptionFieldNo := TempMatrixLocation.FIELDNO(Name)
        else
          CaptionFieldNo := TempMatrixLocation.FIELDNO(Code);

        MatrixMgt.GenerateMatrixData(MatrixRecordRef,SetWanted,ARRAYLEN(MatrixRecords),CaptionFieldNo,MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrSetLength);

        if MATRIX_CaptionSet[1] = '' then begin
          MATRIX_CaptionSet[1] := UnspecifiedLocationCodeTxt;
          MATRIX_CaptionRange := STRSUBSTNO('%1%2',MATRIX_CaptionSet[1],MATRIX_CaptionRange);
        end;

        if MATRIX_CurrSetLength > 0 then begin
          TempMatrixLocation.SETPOSITION(MATRIX_PKFirstRecInCurrSet);
          TempMatrixLocation.FIND;
          repeat
            MatrixRecords[CurrentMatrixRecordOrdinal].COPY(TempMatrixLocation);
            CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
          until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (TempMatrixLocation.NEXT <> 1);
        end;

        UpdateMatrixSubform;
    end;

    local procedure ShowColumnNameOnAfterValidate()
    begin
        SetColumns(MATRIX_SetWanted::Same);
    end;

    local procedure ShowInTransitOnAfterValidate()
    begin
        SetColumns(MATRIX_SetWanted::Initial);
    end;

    local procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet,MatrixRecords,TempMatrixLocation,MATRIX_CurrSetLength);
        CurrPage.MatrixForm.PAGE.SETRECORD(Rec);
        CurrPage.UPDATE(false);
    end;
}

