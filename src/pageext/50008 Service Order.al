pageextension 50008 "Service Order Ext" extends "Service Order"
{
    layout
    {
        addlast(General)
        {
            field(WorkDescrip; WorkDescrip)
            {
                ApplicationArea = All;
                MultiLine = true;
                trigger OnValidate()
                begin
                    Rec.SetWorkDescriptionExt(WorkDescrip);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        WorkDescrip := Rec.GetWorkDescriptionExt;
    end;

    var
        WorkDescrip: Text;
}