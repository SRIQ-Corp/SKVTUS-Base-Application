pageextension 50005 PurchaseOrder extends "Purchase Order"
{

    actions
    {
        addafter(Print)
        {
            action(Test)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                var
                    DocumentAttachment: Record "Document Attachment";
                    TempBlob: Codeunit "Temp Blob";
                    PDFDocumentManagement: Codeunit "PDF Document Management";
                    OutStream: OutStream;
                begin
                    DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
                    DocumentAttachment.SetRange("Document Type", Rec."Document Type");
                    DocumentAttachment.SetRange("No.", Rec."No.");
                    if DocumentAttachment.FindFirst() then begin
                        if DocumentAttachment.HasContent() then;
                        DocumentAttachment."Document Reference ID".ExportStream(OutStream);
                    end;
                end;
            }
        }
    }
}