pageextension 50003 "Posted Service Shipment Ext" extends "Posted Service Shipment"
{
    layout
    {
        addafter(Control1900383207)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = Service;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Service Shipment Header"),
                              "No." = field("No.");
            }
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = Service;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Service Shipment Header"),
                              "No." = field("No.");
            }
        }
    }
}