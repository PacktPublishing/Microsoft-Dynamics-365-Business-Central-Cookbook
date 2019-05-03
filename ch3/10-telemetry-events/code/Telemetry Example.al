page 50130 "Telemetry Example"
{
    Caption = 'Telemetry Example';
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;

    actions
    {
        area(Processing)
        {
            action(RaiseEventCriticalAction)
            {
                Caption = 'Raise Event - Critical';
                ApplicationArea = All;

                trigger OnAction()
                var
                    RaiseTelemetryEvents: Codeunit "Raise Telemetry Events";
                begin
                    RaiseTelemetryEvents.RaiseEvent(Verbosity::Critical);
                end;
            }
            action(RaiseEventErrorAction)
            {
                Caption = 'Raise Event - Error';
                ApplicationArea = All;

                trigger OnAction()
                var
                    RaiseTelemetryEvents: Codeunit "Raise Telemetry Events";
                begin
                    RaiseTelemetryEvents.RaiseEvent(Verbosity::Error);
                end;
            }
            action(RaiseEventWarningAction)
            {
                Caption = 'Raise Event - Warning';
                ApplicationArea = All;

                trigger OnAction()
                var
                    RaiseTelemetryEvents: Codeunit "Raise Telemetry Events";
                begin
                    RaiseTelemetryEvents.RaiseEvent(Verbosity::Warning);
                end;
            }
        }
    }
}