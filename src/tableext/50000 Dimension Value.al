tableextension 50000 DimensionValeExtBase extends "Dimension Value"
{
    fields
    {
        field(50000; "Code No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}