tableextension 50003 "Service Header Ext" extends "Service Header"
{
    fields
    {
        field(50000; "Work Description Ext"; Blob)
        {
            Caption = 'Work Description Ext';
            DataClassification = ToBeClassified;
        }
    }
    procedure SetWorkDescriptionExt(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Work Description Ext");
        "Work Description Ext".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;
    end;

    procedure GetWorkDescriptionExt() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Work Description Ext");
        "Work Description Ext".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), WorkDescription) then
            Message(ReadingDataSkippedMsg, FieldCaption("Work Description Ext"));
    end;

    var
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';
}