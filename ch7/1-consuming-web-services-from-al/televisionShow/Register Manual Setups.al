codeunit 50105 "Register Manual Setups"
{
    [EventSubscriber(ObjectType::Table, Database::"Business Setup", 'OnRegisterBusinessSetup', '', false, false)]
    local procedure OnRegisterBusinessSetup(var TempBusinessSetup: Record "Business Setup")
    var
        TelevisionShowSetupNameTxt: Label 'Television Show Setup';
        TelevisionShowSetupDescriptionTxt: Label 'Set up television show application.';
        KeyWordsTxt: Label 'television, show, tv, setup';
    begin
        TempBusinessSetup.InsertExtensionBusinessSetup(
          TempBusinessSetup, TelevisionShowSetupNameTxt, TelevisionShowSetupDescriptionTxt, KeyWordsTxt,
          TempBusinessSetup.Area::Sales,
          PAGE::"Television Show Setup Card", 'ALProject1');
    end;
}