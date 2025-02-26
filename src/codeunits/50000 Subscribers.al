codeunit 50000 Subscribers
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterGetRefTable, '', false, false)]
    local procedure OnAfterGetRefTable(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")
    var
        ServiceShipmentHeader: Record "Service Shipment Header";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Service Shipment Header":
                begin
                    RecRef.Open(Database::"Service Shipment Header");
                    if ServiceShipmentHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ServiceShipmentHeader);
                end;
            Database::"Gen. Journal Line":
                begin
                    RecRef.Open(Database::"Gen. Journal Line");
                    if GenJournalLine.Get(DocumentAttachment."Journal Template Name", DocumentAttachment."Journal Batch Name", DocumentAttachment."Line No.") then
                        RecRef.GetTable(GenJournalLine);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterTableHasNumberFieldPrimaryKey, '', false, false)]
    local procedure OnAfterTableHasNumberFieldPrimaryKey(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            database::"Service Shipment Header":
                begin
                    FieldNo := 3; // 3
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
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", OnAfterPrepareShipmentHeader, '', false, false)]
    local procedure OnAfterPrepareShipmentHeader(var ServiceShptHeader: Record "Service Shipment Header"; ServiceHeader: Record "Service Header")
    var
        FromRecordRef: RecordRef;
        ToRecordRef: RecordRef;
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        FromFieldRef: FieldRef;
        ToFieldRef: FieldRef;
        FromAttachmentDocumentType: Enum "Attachment Document Type";
        FromNo: Code[20];
        ToNo: Code[20];
    begin
        // FromRecordRef.GetTable(ServiceHeader);
        // ToRecordRef.GetTable(ServiceShptHeader);

        // FromFieldRef := FromRecordRef.Field(3);
        // FromNo := FromFieldRef.Value();
        // FromDocumentAttachment.SetRange("No.", FromNo);
        // FromDocumentAttachment.SetRange("Table ID", FromRecordRef.Number);
        // if FromDocumentAttachment.FindSet() then
        //     repeat
        //         Clear(ToDocumentAttachment);
        //         ToDocumentAttachment.Init();
        //         ToDocumentAttachment.TransferFields(FromDocumentAttachment);
        //         ToDocumentAttachment.Validate("Table ID", ToRecordRef.Number);

        //         ToFieldRef := ToRecordRef.Field(3);
        //         ToNo := ToFieldRef.Value();
        //         ToDocumentAttachment.Validate("No.", ToNo);
        //         Clear(ToDocumentAttachment."Document Type");
        //         ToDocumentAttachment.Insert(true);
        //     until FromDocumentAttachment.Next() = 0;
        TransferDocumentAttchement(ServiceShptHeader, ServiceHeader);
    end;

    local procedure TransferDocumentAttchement(ToRecordVari: Variant; FromRecordVari: Variant)
    var
        FromRecordRef: RecordRef;
        ToRecordRef: RecordRef;
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        FromFieldRef: FieldRef;
        ToFieldRef: FieldRef;
        FromAttachmentDocumentType: Enum "Attachment Document Type";
        FromNo: Code[20];
        ToNo: Code[20];
    begin
        if not (ToRecordVari.IsRecord) then
            Error('Please contact your administrator');
        if not (FromRecordVari.IsRecord) then
            Error('Please contact your administrator');
        FromRecordRef.GetTable(FromRecordVari);
        ToRecordRef.GetTable(ToRecordVari);

        FromFieldRef := FromRecordRef.Field(3);
        FromNo := FromFieldRef.Value();
        FromDocumentAttachment.SetRange("No.", FromNo);
        FromDocumentAttachment.SetRange("Table ID", FromRecordRef.Number);
        if FromDocumentAttachment.FindSet() then
            repeat
                Clear(ToDocumentAttachment);
                ToDocumentAttachment.Init();
                ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                ToDocumentAttachment.Validate("Table ID", ToRecordRef.Number);

                ToFieldRef := ToRecordRef.Field(3);
                ToNo := ToFieldRef.Value();
                ToDocumentAttachment.Validate("No.", ToNo);
                Clear(ToDocumentAttachment."Document Type");
                ToDocumentAttachment.Insert(true);
            until FromDocumentAttachment.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterTableHasLineNumberPrimaryKey, '', false, false)]
    local procedure OnAfterTableHasLineNumberPrimaryKey(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            database::"Gen. Journal Line":
                begin
                    FieldNo := 2;
                    Result := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterSetDocumentAttachmentFiltersForRecRefInternal, '', false, false)]
    local procedure OnAfterSetDocumentAttachmentFiltersForRecRefInternal(var DocumentAttachment: Record "Document Attachment"; RecordRef: RecordRef; GetRelatedAttachments: Boolean)
    var
        FieldRef: FieldRef;
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
        FieldNo: Integer;
    begin
        if DocAttachmentTableHasJournalTemplateNamePrimaryKey(RecordRef.Number(), FieldNo) then begin
            FieldRef := RecordRef.Field(FieldNo);
            JournalTemplateName := FieldRef.Value();
            DocumentAttachment.SetRange("Journal Template Name", JournalTemplateName);
        end;
        if DocAttachmentTableHasJournalBatchNamePrimaryKey(RecordRef.Number(), FieldNo) then begin
            FieldRef := RecordRef.Field(FieldNo);
            JournalBatchName := FieldRef.Value();
            DocumentAttachment.SetRange("Journal Batch Name", JournalBatchName);
        end;
    end;

    local procedure DocAttachmentTableHasJournalTemplateNamePrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean
    var
        Result: Boolean;
    begin
        case TableNo of
            Database::"Gen. Journal Line":
                begin
                    FieldNo := 1;
                    exit(true);
                end;
        end;
        Result := false;
        exit(Result);
    end;

    local procedure DocAttachmentTableHasJournalBatchNamePrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean
    var
        Result: Boolean;
    begin
        case TableNo of
            Database::"Gen. Journal Line":
                begin
                    FieldNo := 51;
                    exit(true);
                end;
        end;
        Result := false;
        exit(Result);
    end;
}