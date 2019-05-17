page 50109 "Scheduled Tasks Example"
{
    PageType = ListPlus;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Scheduled Task";
    SourceTableView = sorting (ID) where ("Run Codeunit" = filter (50109));
    Editable = false;

    layout
    {
        area(Content)
        {
            group(Result)
            {
                field(TaskLastRan; TaskLastRan)
                {
                    Caption = 'Task last ran:';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            repeater(GroupName)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field("Run Codeunit"; "Run Codeunit")
                {
                    ApplicationArea = All;
                }
                field("Not Before"; "Not Before")
                {
                    ApplicationArea = All;
                }
                field("Is Ready"; "Is Ready")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Task")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SimpleTask: Codeunit "A Simple Task";
                begin
                    SimpleTask.AddTaskToScheduler();
                    UpdateResult();
                end;
            }
            action("Set Task to Ready")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SimpleTask: Codeunit "A Simple Task";
                begin
                    SimpleTask.SetTaskToReady(Rec.ID);
                    UpdateResult();
                end;
            }
            action("Delete Task")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SimpleTask: Codeunit "A Simple Task";
                begin
                    SimpleTask.DeleteTaskFromScheduler(Rec.ID);
                    UpdateResult();
                end;
            }
            action("Refresh Page")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    UpdateResult();
                end;
            }
        }
    }

    var
        TaskLastRan: DateTime;

    trigger OnOpenPage()
    begin
        UpdateResult();
    end;

    local procedure UpdateResult()
    var
        SimpleTaskResult: Record "Simple Task Result";
    begin
        clear(TaskLastRan);
        if SimpleTaskResult.Get() then
            TaskLastRan := SimpleTaskResult."DateTime Task Last Ran";
    end;
}