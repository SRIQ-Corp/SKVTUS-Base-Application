pageextension 50009 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    actions
    {
        addafter("&Navigate")
        {
            action(GetPurchRecipt)
            {
                ApplicationArea = All;
                Caption = 'Get Purchase Recipts';
                Image = Receipt;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    GetPurchReciptLines(Rec);
                end;
            }
        }
    }
    local procedure GetPurchReciptLines(var ItemLEntry: Record "Item Ledger Entry")
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.SetRange("Document No.", ItemLEntry."Document No.");
        if PurchRcptLine.FindSet() then
            repeat
                GetPurchInvLines(PurchRcptLine, TempPurchInvLine);
            until PurchRcptLine.Next() = 0;
    end;

    procedure GetPurchInvLines(PRcptLine: Record "Purch. Rcpt. Line"; var TempPurchInvLine: Record "Purch. Inv. Line" temporary)
    var
        PurchInvLine: Record "Purch. Inv. Line";
        ValueItemLedgerEntries: Query "Value Item Ledger Entries";
    begin
        TempPurchInvLine.Reset();
        TempPurchInvLine.DeleteAll();

        if PRcptLine.Type <> PRcptLine.Type::Item then
            exit;

        ValueItemLedgerEntries.SetRange(Item_Ledg_Document_No, PRcptLine."Document No.");
        ValueItemLedgerEntries.SetRange(Item_Ledg_Document_Type, Enum::"Item Ledger Document Type"::"Purchase Receipt");
        ValueItemLedgerEntries.SetRange(Item_Ledg_Document_Line_No, PRcptLine."Line No.");
        ValueItemLedgerEntries.SetFilter(Item_Ledg_Invoice_Quantity, '<>0');
        ValueItemLedgerEntries.SetRange(Value_Entry_Type, Enum::"Cost Entry Type"::"Direct Cost");
        ValueItemLedgerEntries.SetFilter(Value_Entry_Invoiced_Qty, '<>0');
        ValueItemLedgerEntries.SetRange(Value_Entry_Doc_Type, Enum::"Item Ledger Document Type"::"Purchase Invoice");
        ValueItemLedgerEntries.Open();
        while ValueItemLedgerEntries.Read() do
            if PurchInvLine.Get(ValueItemLedgerEntries.Value_Entry_Doc_No, ValueItemLedgerEntries.Value_Entry_Doc_Line_No) then begin
                TempPurchInvLine.Init();
                TempPurchInvLine := PurchInvLine;
                if TempPurchInvLine.Insert() then;
            end;
    end;

    var
        TempPurchInvLine: Record "Purch. Inv. Line" temporary;
}