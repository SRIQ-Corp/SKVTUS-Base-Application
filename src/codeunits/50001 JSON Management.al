codeunit 50001 "JSON Management Code"
{
    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        HeaderJsonObj.Add('Status', 'Sucesses');
        HeaderJsonObj.Add('Message', 'Data Retrive sucessesfully');
        SalesHeader.Get(SalesHeader."Document Type"::Order, 'S-ORD101001');
        SalesHeaderJsonObj.Add('Order No.', SalesHeader."No.");
        SalesHeaderJsonObj.Add('Customer No.', SalesHeader."Sell-to Customer No.");
        SalesHeaderJsonObj.Add('Posting Date.', SalesHeader."Posting Date");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                Clear(SalesLineJsonObj);
                SalesLineJsonObj.Add('Type', SalesLine.Type.AsInteger());
                SalesLineJsonObj.Add('No', SalesLine."No.");
                SalesLineJsonObj.Add('Description', SalesLine.Description);
                SalesLineJsonObj.Add('Amount', SalesLine.Amount);
                SalesLineJsonArray.Add(SalesLineJsonObj);
            until SalesLine.Next() = 0;
        SalesHeaderJsonObj.Add('Lines', SalesLineJsonArray);
        HeaderJsonObj.Add('Data', SalesHeaderJsonObj);
        //Message(Format(HeaderJsonObj));
        ReadJson(HeaderJsonObj);
    end;

    local procedure ReadJson(JsonRespons: JsonObject)
    var
        JsonText1, JsonText2 : Text;
        JsonToken1, JsonToken2, JsonToken3 : JsonToken;
        JsonData, JsonLine : JsonObject;
        JsonValueOrderNo: JsonValue;
        JsonArrySalesLines: JsonArray;
    begin
        JsonRespons.Get('Data', JsonToken1);
        JsonData := JsonToken1.AsObject();
        JsonData.Get('Lines', JsonToken2);
        JsonArrySalesLines := JsonToken2.AsArray();
        // foreach JsonToken3 in JsonArrySalesLines do begin
        //     Message(Format(JsonToken3));
        // end;

    end;

    var
        HeaderJsonObj: JsonObject;
        SalesHeaderJsonObj: JsonObject;
        SalesLineJsonObj: JsonObject;
        SalesLineJsonArray: JsonArray;
}