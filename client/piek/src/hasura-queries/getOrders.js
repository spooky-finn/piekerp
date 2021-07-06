import gql from 'graphql-tag'; 

export const GetOrdersSubscription = gql`

subscription GetOrders {
    erp_Orders {
      Entity
      InvoiceNumber
      City
      ShippingDate
      PaidAmount
      TotalAmount
      OrderItems {
        Quantity
        OrderItemID
        Name
        OrderID
        
      }
      
    }
  }

`