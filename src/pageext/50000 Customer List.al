pageextension 50000 CustomerListSqBase extends "Customer List"
{
    actions
    {
        addafter("Customer - Order Summary")
        {
            action(SendHttpReq)
            {
                ApplicationArea = All;
                Caption = 'Send Http Request';
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    HttpClient: HttpClient;
                    HttpResponseMessage: HttpResponseMessage;
                    URL: Label 'https://catfact.ninja/fact';
                    ResponsText: Text;
                begin
                    if HttpClient.Get(URL, HttpResponseMessage) then begin
                        HttpResponseMessage.Content.ReadAs(ResponsText);
                        Message(ResponsText);
                    end;
                end;
            }
            action(GetLoaction)
            {
                ApplicationArea = All;
                Caption = 'Get Location';
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    Geolocation: Codeunit Geolocation;
                    Latitude: Decimal;
                    Longitude: Decimal;
                begin
                    Geolocation.SetHighAccuracy(true);
                    if Geolocation.RequestGeolocation() then begin
                        Geolocation.GetGeolocation(Latitude, Longitude);
                        Message('Latitude - %1, Longitude - %2', Latitude, Longitude);
                    end;
                end;
            }
            action(JsonReader)
            {
                ApplicationArea = All;
                Caption = 'JSON Reader';
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"JSON Management Code")
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        Customer: Record Customer;
        TempCustomer: Record Customer temporary;
        RecRef: RecordRef;
        FRef: FieldRef;
        FielNo: Integer;
    begin
        //Codeunit.Run(Codeunit::"JSON Management Code")
        //RecRef.Open(Database::Customer);
        //if Customer.Get('10000') then;
        //RecRef.GetTable(Customer);
        // if RecRef.Find('-') then
        //     Message('Find First Record %1', RecRef.Count)
        // else
        //     Message('Not Find Record');
        if Customer.FindSet() then
            repeat
                TempCustomer.Init();
                TempCustomer.Insert();
                TempCustomer.Validate("No.", Customer."No.");
                TempCustomer.Validate(Name, Customer.Name);
            until Customer.Next() = 0;
        RecRef.GetTable(TempCustomer);
        if RecRef.Find('-') then
            Message(Format(RecRef.Count));
    end;
}