pageextension 50001 DimennsionValuesExtBase extends "Dimension Values"
{
    layout
    {
        addafter(Code)
        {

        }
    }
    var
        TempDimensionValue: Record "Dimension Value" temporary;

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnOpenPage()
    begin

    end;
}