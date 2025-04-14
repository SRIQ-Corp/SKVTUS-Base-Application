pageextension 50006 "Customer Card Ext" extends "Customer Card"
{
    trigger OnModifyRecord(): Boolean
    var
        Field: Record Field;
        TypeHelper: Codeunit "Type Helper";
        RecRef, XRecRef : RecordRef;
        FRef, XFRef : FieldRef;
        LoopCount: Integer;
    begin
        RecRef.GetTable(Rec);
        XRecRef.GetTable(xRec);
        for LoopCount := 1 to RecRef.FieldCount do begin
            FRef := RecRef.FieldIndex(LoopCount);
            XFRef := XRecRef.FieldIndex(LoopCount);
            if FRef.Value <> XFRef.Value then
                Message('First Value %1 \ Second Value %2', XFRef.Value, FRef.Value);
        end;
    end;
}