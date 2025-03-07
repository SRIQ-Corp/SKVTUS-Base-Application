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
    begin
        Codeunit.Run(Codeunit::"JSON Management Code")
    end;
}