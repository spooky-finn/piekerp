import { gql } from "graphql-tag"

export const GET_ARCHIVED_UNPAID_ORDERS = gql`
query MyQuery($unpaidIDs: [Int!], $OrderStatus: Int!) {
    erp_Orders(where: { OrderStatusID: {_eq: $OrderStatus}, OrderID: {_in: $unpaidIDs } } ) {
      OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      PaidAmount
      TotalAmount
      AwaitingDispatch
      ActualShippingDate
      CreatingDate
      ManagerID
      OrderItems {
        Quantity
        OrderItemID
        Name
      } 
      User {
        FirstName
      }
    }
  }
`