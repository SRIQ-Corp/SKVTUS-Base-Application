pageextension 50007 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addafter("No.")
        {
            field("Sell to Contact No Ext"; Rec."Sell to Contact No Ext")
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    if not Rec.ContactLookUp() then begin
                        exit(false);
                        Message('Exit with false');
                    end;
                    Text := Rec."Sell to Contact No Ext";
                    exit(true);
                end;
            }
        }
    }
}