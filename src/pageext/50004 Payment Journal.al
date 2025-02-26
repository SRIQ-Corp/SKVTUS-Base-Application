pageextension 50004 PaymentJournal extends "Payment Journal"
{
    layout
    {
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Gen. Journal Line"),
                                "Journal Template Name" = FIELD("Journal Template Name"),
                                "Journal Batch Name" = FIELD("Journal Batch Name"),
                                "Line No." = FIELD("Line No.");
            }
        }
    }
}