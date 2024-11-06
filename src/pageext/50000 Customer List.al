pageextension 50000 CustomerListSqBase extends "Customer List"
{
    trigger OnOpenPage()
    begin
        Message('Test');
    end;
}