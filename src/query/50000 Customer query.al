query 50000 "Customer Query"
{
    Caption = 'Customer Query';
    QueryCategory = 'Customer List';
    elements
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
        }
    }
}