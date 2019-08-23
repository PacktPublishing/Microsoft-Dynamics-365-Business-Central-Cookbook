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
    StartupScript = 'src/ControlAddIn/startup.js';
    Scripts = 'src/ControlAddIn/controlAddIn.js';
    StyleSheets = 'src/ControlAddIn/style.css';

    procedure SetTelevisionShow(TelevisionShow: JsonObject);
    event ControlReady();
}