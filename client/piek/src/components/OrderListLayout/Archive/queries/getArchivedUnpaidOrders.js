import { gql } from "graphql-tag"

export const GET_ARCHIVED_UNPAID_ORDERS = gql`
query MyQuery($unpaidIDs: [Int!]) {
    erp_Orders(where: { OrderStatusID: {_eq: 3}, OrderID: {_in: $unpaidIDs } } ) {
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