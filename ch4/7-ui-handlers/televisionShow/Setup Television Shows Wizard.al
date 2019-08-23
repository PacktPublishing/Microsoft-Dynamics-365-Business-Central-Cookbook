page 50107 "Load Television Shows Wizard"
{
    Caption = 'Load Television Shows';
    PageType = NavigatePage;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and not FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(step1)
            {
                Visible = Step1Visible;
                group(Welcome)
                {
                    Caption = 'Welcome to the Television Shows application!';
                    Visible = Step1Visible;
                    group(Welcome1)
                    {
                        Caption = '';
                        InstructionalText = 'This wizard will let you select which genre of television shows we should load for sample data.';
                    }
                }
                group(LetsGo)
                {
                    Caption = 'Let''s go!';
                    group(LetsGo1)
                    {
                        Caption = '';
                        InstructionalText = 'Press Next to continue.';
                    }
                }
            }
            group(step2)
            {
                Caption = '';
                InstructionalText = 'Select the genre(s) of television shows you want to load.';
                Visible = Step2Visible;

                field(Genre1Selected; Genre1Selected)
                {
                    Caption = 'Comedy';
                    ApplicationArea = All;
                }
                field(Genre2Selected; Genre2Selected)
                {
                    Caption = 'Drama';
                    ApplicationArea = All;
                }
                field(Genre3Selected; Genre3Selected)
                {
                    Caption = 'Family';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction();
                begin
                    FinishAction();
                end;
            }
        }
    }

    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    begin
        UpdateTelevisionShowSetupToNotFinished();
        Step := Step::Start;
        EnableControls();
    end;

    var
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,Finish;
        BackActionEnabled: Boolean;
        FinishActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        TopBannerVisible: Boolean;
        Genre1Selected: Boolean;
        Genre2Selected: Boolean;
        Genre3Selected: Boolean;

    local procedure EnableControls();
    begin
        ResetControls();

        case Step of
            Step::Start:
                ShowStep1;
            Step::Finish:
                ShowStep2;
        end;
    end;

    local procedure FinishAction();
    begin
        TestGenresSelected();
        LoadTelevisionShows();
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        ELSE
            Step := Step + 1;

        EnableControls();
    end;

    local procedure ShowStep1();
    begin
        Step1Visible := true;

        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowStep2();
    begin
        Step2Visible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        Step1Visible := false;
        Step2Visible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.GET('AssistedSetup-NoText-400px.png', FORMAT(CurrentClientType())) AND
           MediaRepositoryDone.GET('AssistedSetupDone-NoText-400px.png', FORMAT(CurrentClientType()))
        then
            if MediaResourcesStandard.GET(MediaRepositoryStandard."Media Resources Ref") AND
               MediaResourcesDone.GET(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;

    local procedure TestGenresSelected()
    var
        NothingSelectedConfirmLbl: Label 'You did not select any genres so no data will be loaded. Are you sure you want to exit?';
    begin
        if (not Genre1Selected) and (not Genre2Selected) and (not Genre3Selected) then
            if not Confirm(NothingSelectedConfirmLbl, false) then
                Error('');
    end;

    local procedure LoadTelevisionShows();
    var
        LoadTelevisionShows: Codeunit "Load Television Shows";
    begin
        LoadTelevisionShows.LoadTelevisionShows(Genre1Selected, Genre2Selected, Genre3Selected);
    end;

    local procedure UpdateTelevisionShowSetupToNotFinished()
    var
        TelevisionShowSetup: Record "Television Show Setup";
    begin
        TelevisionShowSetup."Finished Assisted Setup" := false;
        TelevisionShowSetup.Modify();
    end;
}