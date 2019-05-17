report 50101 "Customer Listing With TV Shows"
{
    Caption = 'Customer Listing With Television Shows';
    DefaultLayout = RDLC;
    RDLCLayout = 'Customer Listing With Television Shows.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(CustomerNo; "No.")
            {
            }
            column(CustomerName; Name)
            {
            }
            dataitem("Customer Television Show"; "Customer Television Show")
            {
                DataItemLinkReference = Customer;
                DataItemLink = "Customer No." = field ("No.");

                column(TelevisionShowCode; "Television Show Code")
                {
                }
                column(TelevisionShowName; TelevisionShowName)
                {
                }
                column(Favorite; Favorite)
                {
                }

                trigger OnAfterGetRecord()
                var
                    TelevisionShow: Record "Television Show";
                begin
                    clear(TelevisionShowName);
                    if TelevisionShow.get("Television Show Code") then
                        TelevisionShowName := TelevisionShow.Name;
                end;
            }
        }
    }

    var
        TelevisionShowName: Text;
}

