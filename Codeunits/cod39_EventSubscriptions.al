codeunit 50139 EventSubscriptions
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-1
{
    [EventSubscriber(ObjectType::Codeunit, 212, 'OnBeforeResLedgEntryInsert', '', true, true)]
    local procedure PostResJnlLineOnBeforeResLedgEntryInsert(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line");
    var
        c: Codeunit "Res. Jnl.-Post Line";
    begin
        ResLedgerEntry."CSD Seminar No." := ResJournalLine."CSD Seminar No.";
        ResLedgerEntry."CSD Seminar Registration No." := ResJournalLine."CSD Seminar Registration No.";
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', true, true)]
    local procedure FindRecords(VAR DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    var
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
        PostedSemRegHdr: Record "CSD Posted Seminar Reg. Header";
    begin
        if SeminarLedgerEntry.ReadPermission() then begin
            SeminarLedgerEntry.reset;
            SeminarLedgerEntry.SetFilter("Document No.", DocNoFilter);
            SeminarLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"CSD Seminar Ledger Entry", 0, SeminarLedgerEntry.TableCaption(), SeminarLedgerEntry.Count());
        end;
        if PostedSemRegHdr.ReadPermission() then begin
            PostedSemRegHdr.Reset();
            PostedSemRegHdr.SetFilter("No.", DocNoFilter);
            PostedSemRegHdr.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"CSD Posted Seminar Reg. Header", 0, PostedSemRegHdr.TableCaption(), PostedSemRegHdr.Count());
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure ShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; VAR TempDocumentEntry: Record "Document Entry")
    var
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
        PostedSemRegHdr: Record "CSD Posted Seminar Reg. Header";
    begin
        case TableID of
            Database::"CSD Posted Seminar Reg. Header":
                begin
                    PostedSemRegHdr.SetFilter("No.", DocNoFilter);
                    PostedSemRegHdr.SetFilter("Posting Date", PostingDateFilter);
                    page.Run(0, PostedSemRegHdr);
                end;
            Database::"CSD Seminar Ledger Entry":
                begin
                    SeminarLedgerEntry.SetFilter("Document No.", DocNoFilter);
                    SeminarLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
                    Page.Run(0, SeminarLedgerEntry);
                end;
        end;
    end;

    local procedure InsertIntoDocEntry(VAR TempDocumentEntry: Record "Document Entry"; DocTableID: Integer; DocType: Integer; DocTableName: Text; DocNoOfRecords: Integer)
    begin
        IF DocNoOfRecords = 0 THEN
            EXIT;

        WITH TempDocumentEntry DO BEGIN
            INIT;
            "Entry No." := "Entry No." + 1;
            "Table ID" := DocTableID;
            "Document Type" := DocType;
            "Table Name" := COPYSTR(DocTableName, 1, MAXSTRLEN("Table Name"));
            "No. of Records" := DocNoOfRecords;
            INSERT;
        END;
    end;
}
