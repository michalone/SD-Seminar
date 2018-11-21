table 50104 "CSD Seminar Comment Line"
{
    Caption = 'Seminar Comment Line';
    DrillDownPageId = "CSD Seminar Comment List";
    LookupPageId = "CSD Seminar Comment List";

    fields
    {
        field(10; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionMembers = "Seminar","Seminar Registration","Posted Seminar Registration";
            OptionCaption = 'Seminar,Seminar Registration,Posted Seminar Registration';
        }
        field(20; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(30; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if ("Table Name" = CONST (Seminar)) "CSD Seminar" else
            if ("Table Name" = const ("Seminar Registration")) "CSD Seminar Reg. Header";
        }
        field(40; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(50; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(60; Code; Code[10])
        {
            Caption = 'Code';
        }
        field(70; Comment; Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(PK; "Table Name", "Document Line No.", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure SetupNewLine()
    var
        CommentLine: Record "CSD Seminar Comment Line";
    begin
        CommentLine := Rec;
        CommentLine.SetRecFilter();
        CommentLine.SetRange("Line No.");
        if CommentLine.IsEmpty() then
            Date := WorkDate();
    end;
}