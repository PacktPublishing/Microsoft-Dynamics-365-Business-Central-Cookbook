report 50100 "Television Shows Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Television Shows Report.rdl';

    dataset
    {
        dataitem("Television Show"; "Television Show")
        {
            RequestFilterFields = Code, "First Aired", "Last Aired", Status;

            column(Code; Code)
            {

            }
            column(Name; Name)
            {

            }
            column(First_Aired; "First Aired")
            {

            }
            column(Last_Aired; "Last Aired")
            {

            }
        }
    }
}