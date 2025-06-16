query 50001 "Sales Orders Query"
{
    Caption = 'Sales Order Query';
    QueryCategory = 'Sales Order List';
    elements
    {
        dataitem(Sales_Header; "Sales Header")
        {
            DataItemTableFilter = "Document Type" = filter('Order');
            column(Document_Type; "Document Type")
            {
            }
            column(No_; "No.")
            {
            }
            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Document No." = Sales_Header."No.";
                DataItemTableFilter = Type = filter('Item');
                column(Quantity; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }
}