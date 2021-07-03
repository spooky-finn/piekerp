import gql from 'graphql-tag'; 

export const GetOrdersSubscription = gql`

subscription GetOrders {
    erp_Orders {
      Entity
      InvoiceNumber
      OrderItems {
        Quantity
        OrderItemID
        Name
        OrderID
      }
      City
      ShippingDate
    }
  }

`