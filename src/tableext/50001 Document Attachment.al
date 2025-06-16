tableextension 50001 DocumentAttachmentSqBase extends "Document Attachment"
{
    fields
    {
        field(50000; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
}