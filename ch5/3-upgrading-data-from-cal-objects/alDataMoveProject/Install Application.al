codeunit 50010 "Install Application"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        MoveCustomerLevelData();
        MoveCustomerFields();
    end;

    local procedure MoveCustomerLevelData()
    var
        OldCustomerLevel: Record "Customer Level TMP";
        NewCustomerLevel: Record "Customer Level";
    begin
        if OldCustomerLevel.FindSet() then begin
            repeat
                NewCustomerLevel.Init();
                NewCustomerLevel.TransferFields(OldCustomerLevel);
                NewCustomerLevel.Insert(true);
            until OldCustomerLevel.Next() = 0;

            OldCustomerLevel.DeleteAll();
        end;
    end;

    local procedure MoveCustomerFields()
    var
        Customer: Record Customer;
    begin
        if Customer.FindSet() then begin
            repeat
                Customer."Level Code" := Customer."Level Code TMP";
                Customer."Level Code TMP" := '';

                MoveClassificationField(Customer);

                Customer.Modify(true);
            until Customer.Next() = 0;
        end;
    end;

    local procedure MoveClassificationField(var Customer: Record Customer)
    var
        Classification: Record Classification;
    begin
        if Customer."Classification TMP" = '' then
            exit;

        Customer.Classification := UpperCase(Customer."Classification TMP");
        Customer."Classification TMP" := '';

        if not Classification.Get(Customer.Classification) then begin
            Classification.Init();
            Classification.Code := Customer.Classification;
            Classification.Description := Classification.Code;
            Classification.Insert(true);
        end;
    end;
}