codeunit 50000 Subscribers
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterGetRefTable, '', false, false)]
    local procedure OnAfterGetRefTable(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")
    var
        ServiceShipmentHeader: Record "Service Shipment Header";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Service Shipment Header":
                begin
                    RecRef.Open(Database::"Service Shipment Header");
                    if ServiceShipmentHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ServiceShipmentHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterIsServiceDocumentFlow, '', false, false)]
    local procedure OnAfterIsServiceDocumentFlow(TableNo: Integer; var IsDocumentFlow: Boolean)
    begin
        if TableNo in [Database::"Service Header",
                        Database::"Service Shipment Header"] then
            IsDocumentFlow := true
        else
            IsDocumentFlow := false;
    end;
}