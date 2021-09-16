import { gql } from "graphql-tag"

export const GET_ARCHIVED_ORDERS = gql`
  query{
    erp_Orders(where: {OrderStatusID: {_eq: 3} }) {
      OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      AcceptanceDate
      PaidAmount
      TotalAmount
      AwaitingDispatch
      CreatingDate
      ManagerID
      OrderStatus {
        Name
        ID
      }
      OrderItems {
        Quantity
        OrderItemID
        Name
        OrderID
      } 
      User {
        FirstName
      }

    }  
  }
`
