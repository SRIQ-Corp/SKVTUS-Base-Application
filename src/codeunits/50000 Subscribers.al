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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterTableHasNumberFieldPrimaryKey, '', false, false)]
    local procedure OnAfterTableHasNumberFieldPrimaryKey(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            database::"Service Shipment Header":
                begin
                    FieldNo := 44; // 3
                    Result := true;
                end;
        end;
    end;
    // [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", OnAfterOpenForRecRef, '', false, false)]
    // local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    // begin
    //     SetRelatedAttachmentsFilterForServiceShipmentHeader(RecRef.Number(), DocumentAttachment);
    // end;

    // local procedure SetRelatedAttachmentsFilterForServiceShipmentHeader(TableNo: Integer; var DocumentAttachment: Record "Document Attachment")
    // var
    //     myInt: Integer;
    // begin

    // end;
}