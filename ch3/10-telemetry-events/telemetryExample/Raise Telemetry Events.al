codeunit 50130 "Raise Telemetry Events"
{
    procedure RaiseEvent(Level: Verbosity)
    var
        CriticalEventMsg: Label 'A critical event';
        ErrorEventMsg: Label 'A error event';
        WarningEventMsg: Label 'A warning event';
        NormalEventMsg: Label 'A normal event';
        CategoryTxt: Label 'Page Action';
        EventRaiseMsg: Label 'Event raised';
    begin
        case Level of
            level::Critical:
                SendTraceTag('TelEx-000', CategoryTxt, Level, CriticalEventMsg, DataClassification::CustomerContent);
            level::Error:
                SendTraceTag('TelEx-001', CategoryTxt, Level, ErrorEventMsg, DataClassification::CustomerContent);
            level::Warning:
                SendTraceTag('TelEx-002', CategoryTxt, Level, WarningEventMsg, DataClassification::CustomerContent);
        end;

        Message(EventRaiseMsg);
    end;
}