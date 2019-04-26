table 50102 "Television Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(2; Active; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Television Show" where (Status = const (Active)));
        }
        field(3; Finished; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Television Show" where (Status = const (Finished)));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}