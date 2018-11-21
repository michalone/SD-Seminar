report 50101 "CSD SeminarRegParticipantList"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Seminar Reg.- Participant List';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SeminarRegParticipantList.rdl';

    dataset
    {
        dataitem("Seminar Registration Header"; "CSD Seminar Reg. Header")
        {
            DataItemTableView = sorting ("No.");
            RequestFilterFields = "No.", "Seminar No.";
            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(SeminarNo_; "Seminar No.")
            {
                IncludeCaption = true;
            }
            column(SeminarName; "Seminar Name")
            {
                IncludeCaption = true;
            }
            column(StartingDate; "Starting Date")
            {
                IncludeCaption = true;
            }
            column(Duration; Duration)
            {
                IncludeCaption = true;
            }
            column(InstructorName; "Instructor Name")
            {
                IncludeCaption = true;
            }
            column(RoomName; "Room Name")
            {
                IncludeCaption = true;
            }
            dataitem("Seminar Registration Line"; "CSD Seminar Registration Line")
            {
                DataItemTableView = sorting ("Document No.", "Line No.");
                DataItemLink = "Document No." = field ("No.");

                column(Bill_to_Customer_No_; "Bill-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Contact_No_; "Participant Contact No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Name; "Participant Name")
                {
                    IncludeCaption = true;
                }
            }
        }
        dataitem("Company Information"; "Company Information")
        {
            column(CompanyName; Name)
            {

            }
        }
    }

    labels
    {
        SeminarRegNoTitle = 'Seminar Registration List';
    }
    var
        myInt: Integer;
}