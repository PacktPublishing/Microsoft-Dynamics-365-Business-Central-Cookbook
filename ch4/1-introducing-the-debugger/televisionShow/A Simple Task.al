codeunit 50109 "A Simple Task"
{
    trigger OnRun()
    begin
        SimpleTaskFunction();
    end;

    local procedure SimpleTaskFunction()
    var
        SimpleTaskResult: Record "Simple Task Result";
    begin
        SimpleTaskResult.UpdateWithNewRun();
    end;

    procedure AddTaskToScheduler()
    begin
        TaskScheduler.CreateTask(Codeunit::"A Simple Task", 0, false, '', CurrentDateTime());
    end;

    procedure DeleteTaskFromScheduler(TaskID: Guid)
    begin
        TaskScheduler.CancelTask(TaskID);
    end;

    procedure SetTaskToReady(TaskId: Guid)
    begin
        TaskScheduler.SetTaskReady(TaskId);
    end;
}