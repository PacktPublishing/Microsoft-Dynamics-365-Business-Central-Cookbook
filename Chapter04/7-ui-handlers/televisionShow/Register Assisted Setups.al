codeunit 50106 "Register Assisted Setups"
{
    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', false, false)]
    local procedure OnRegisterAssistedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" TEMPORARY);
    var
        AssistedSetupRecord: Record "Television Show";
    begin
        TempAggregatedAssistedSetup.AddExtensionAssistedSetup(
            Page::"Load Television Shows Wizard", 'Load Television Shows', True,
            AssistedSetupRecord.RecordId(), GetAssistedSetupStatus(TempAggregatedAssistedSetup), '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnUpdateAssistedSetupStatus', '', false, false)]
    local procedure OnUpdateAssistedSetupStatus(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" TEMPORARY);
    begin
        TempAggregatedAssistedSetup.SetStatus(TempAggregatedAssistedSetup, Page::"Load Television Shows Wizard", GetAssistedSetupStatus(TempAggregatedAssistedSetup));
    end;

    local procedure GetAssistedSetupStatus(AggregatedAssistedSetup: Record "Aggregated Assisted Setup"): Integer;
    var
        TelevisionShowSetup: Record "Television Show Setup";
    begin
        with AggregatedAssistedSetup do begin
            if TelevisionShowSetup.Get() then begin
                if TelevisionShowSetup."Finished Assisted Setup" then
                    Status := Status::Completed
                else
                    Status := Status::"Not Completed";
            end else
                Status := Status::"Not Completed";
            exit(Status);
        end;
    end;
}