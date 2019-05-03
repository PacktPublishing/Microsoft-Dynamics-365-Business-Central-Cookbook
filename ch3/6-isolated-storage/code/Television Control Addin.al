controladdin TelevisionControlAddIn
{
    RequestedHeight = 75;
    MinimumHeight = 75;
    MaximumHeight = 75;
    RequestedWidth = 300;
    MinimumWidth = 300;
    MaximumWidth = 300;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    StartupScript = 'ControlAddIn/startup.js';
    Scripts = 'ControlAddIn/controlAddIn.js';
    StyleSheets = 'ControlAddIn/style.css';

    procedure SetTelevisionShow(TelevisionShow: JsonObject);
    event ControlReady();
}