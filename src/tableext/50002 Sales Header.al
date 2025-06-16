tableextension 50002 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Sell to Contact No Ext"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnLookup()
            begin
                //ContactLookUp();
                DefaultLookUp();
            end;
        }
    }
    procedure ContactLookUp(): Boolean
    var
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        if "Sell-to Customer No." <> '' then
            if Contact.Get("Sell-to Contact No.") then
                Contact.SetRange("Company No.", Contact."Company No.")
            else
                if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Customer, "Sell-to Customer No.") then
                    Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.")
                else
                    Contact.SetRange("No.", '');
        if page.RunModal(0, Contact) = Action::LookupOK then begin
            Validate("Sell to Contact No Ext", Contact."No.");
            exit(true);
        end;
        exit(false);
    end;

    local procedure DefaultLookUp()
    var
        Customer: Record Customer;
    begin
        Customer.SetRange("No.", "Sell-to Customer No.");
        if Page.RunModal(0, Customer) = Action::LookupOK then begin
            Validate("Sell to Contact No Ext", Customer."No.");
        end;
    end;

}