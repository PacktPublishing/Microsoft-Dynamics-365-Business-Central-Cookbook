codeunit 50000 CallAzureFunction
{
    procedure CallAzureFunctionDemo(CustomerName: Text) ResponseText: Text
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        AzureFunctionAppBaseUrl: Label '<replace with your Azure Function App url>';
        FullUrl: Text;
        RequestErr: Label 'An error occurred when calling the Azure Function:\\%1:\\%2';
    begin
        FullUrl := AzureFunctionAppBaseUrl + '&name=' + CustomerName;

        Client.Get(FullUrl, ResponseMessage);
        if not ResponseMessage.IsSuccessStatusCode() then
            Error(RequestErr, ResponseMessage.HttpStatusCode, ResponseMessage.ReasonPhrase);
        ResponseMessage.Content().ReadAs(ResponseText);
    end;
}