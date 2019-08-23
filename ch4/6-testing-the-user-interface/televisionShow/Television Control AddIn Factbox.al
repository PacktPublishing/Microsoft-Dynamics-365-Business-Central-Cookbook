page 50105 "Television Control AddIn Fctbx"
{
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            usercontrol(TelevisionControlAddIn; TelevisionControlAddIn)
            {
                ApplicationArea = All;
                Visible = true;

                trigger ControlReady()
                begin
                    GetFavoriteTelevisionShow();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetFavoriteTelevisionShow();
    end;

    local procedure GetFavoriteTelevisionShow()
    var
        CustomerTelevisionShow: Record "Customer Television Show";
        FavoriteShow: JsonObject;
        NoneFoundLbl: Label 'None found';
    begin
        CustomerTelevisionShow.SetRange("Customer No.", "No.");
        CustomerTelevisionShow.SetRange(Favorite, true);
        if CustomerTelevisionShow.FindFirst() then begin
            FavoriteShow.Add('name', GetShowName(CustomerTelevisionShow."Television Show Code"));
            FavoriteShow.Add('url', MakeTvdbUrl(GetShowName(CustomerTelevisionShow."Television Show Code")));
        end else begin
            FavoriteShow.Add('name', NoneFoundLbl);
            FavoriteShow.Add('url', '');
        end;
        CurrPage.TelevisionControlAddin.SetTelevisionShow(FavoriteShow);
    end;

    local procedure GetShowName(ShowCode: Code[20]): Text
    var
        TelevisionShow: Record "Television Show";
    begin
        if ShowCode <> '' then begin
            TelevisionShow.Get(ShowCode);
            exit(TelevisionShow.Name);
        end;
    end;

    local procedure MakeTvdbUrl(ShowName: Text) Url: Text
    var
        UrlBase: Label 'https://www.thetvdb.com/search?q=';
    begin
        if ShowName <> '' then begin
            ShowName := ConvertStr(DelChr(ShowName, '<>', ' '), ' ', '+');
            Url := UrlBase + ShowName;
        end;
    end;
}