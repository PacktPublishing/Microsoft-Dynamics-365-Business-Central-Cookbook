codeunit 50110 "Download Episode Information"
{
    procedure DownloadTvShowEpisodes(TelevisionShow: Record "Television Show")
    begin
        if EpisodeEntriesExist(TelevisionShow.Code) then
            DeleteExistingEpisodes(TelevisionShow.Code);

        DownloadEpisodes(TelevisionShow);
        ShowSuccessMessage();
    end;

    local procedure EpisodeEntriesExist(TelevisionShowCode: Code[20]): Boolean
    var
        TelevisionShowEpisode: Record "Television Show Episode";
    begin
        TelevisionShowEpisode.SetRange("Television Show Code", TelevisionShowCode);
        exit(not TelevisionShowEpisode.IsEmpty());
    end;

    local procedure DeleteExistingEpisodes(TelevisionShowCode: Code[20])
    var
        TelevisionShowEpisode: Record "Television Show Episode";
    begin
        TelevisionShowEpisode.SetRange("Television Show Code", TelevisionShowCode);
        TelevisionShowEpisode.DeleteAll();
    end;

    local procedure ShowSuccessMessage()
    var
        SuccessMessageTxt: Label 'Episode information has been downloaded.';
    begin
        if GuiAllowed() then
            Message(SuccessMessageTxt);
    end;

    local procedure DownloadEpisodes(TelevisionShow: Record "Television Show")
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        JsonContentText: Text;
        Url: Text;
        MissingIdErr: Label 'You must populate the %1 before you can download episodes.';
        RequestErr: Label 'An error ocurred when trying to get the episodes:\\%1:\\%2';
        WrongFormatErr: Label 'The response is not formatted correctly.';
        Counter: Integer;
    begin
        If TelevisionShow."TVMaze ID" = 0 then
            Error(MissingIdErr, TelevisionShow.FieldCaption("TVMaze ID"));
        Url := 'http://api.tvmaze.com/shows/' + Format(TelevisionShow."TVMaze ID") + '/episodes';
        Client.Get(Url, ResponseMessage);
        if not ResponseMessage.IsSuccessStatusCode() then
            Error(RequestErr, ResponseMessage.HttpStatusCode, ResponseMessage.ReasonPhrase);
        ResponseMessage.Content().ReadAs(JsonContentText);
        if not JsonArray.ReadFrom(JsonContentText) then
            Error(WrongFormatErr);
        for Counter := 0 to JsonArray.Count() - 1 do begin
            JsonArray.Get(Counter, JsonToken);
            JsonObject := JsonToken.AsObject();
            CreateTelevisionShowEpisodeEntry(TelevisionShow, JsonObject)
        end;
    end;

    local procedure CreateTelevisionShowEpisodeEntry(TelevisionShow: Record "Television Show"; JsonObject: JsonObject)
    var
        TelevisionShowEpisode: Record "Television Show Episode";
        JsonToken: JsonToken;
    begin
        TelevisionShowEpisode.Init();
        TelevisionShowEpisode."Television Show Code" := TelevisionShow.Code;
        GetJsonToken(JsonObject, 'id', JsonToken);
        TelevisionShowEpisode."Episode ID" := JsonToken.AsValue().AsInteger();
        GetJsonToken(JsonObject, 'name', JsonToken);
        TelevisionShowEpisode.Name := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TelevisionShowEpisode.Name));
        GetJsonToken(JsonObject, 'season', JsonToken);
        TelevisionShowEpisode."Season No." := JsonToken.AsValue().AsInteger();
        GetJsonToken(JsonObject, 'number', JsonToken);
        TelevisionShowEpisode."Episode No." := JsonToken.AsValue().AsInteger();
        GetJsonToken(JsonObject, 'airdate', JsonToken);
        TelevisionShowEpisode."Air Date" := JsonToken.AsValue().AsDate();
        GetJsonToken(JsonObject, 'summary', JsonToken);
        TelevisionShowEpisode.Summary := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TelevisionShowEpisode.Summary));
        TelevisionShowEpisode.Insert();
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; KeyText: Text; var JsonToken: JsonToken)
    var
        CannotFindKeyErr: Label 'Cannot find the following key: %1';
    begin
        if not JsonObject.Get(KeyText, JsonToken) then
            error(CannotFindKeyErr, KeyText);
    end;
}