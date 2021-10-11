import { gql } from "graphql-tag"

export const GET_ARCHIVED_SEARCH_ORDERS = gql`
  query ($keyword: String!){
  erp_Orders(where: {
    _or: [
      { Entity: {_ilike: $keyword} }, 
      { InvoiceNumber: {_ilike: $keyword} }

      ],
    OrderStatusID: {_eq: 3}
    }) {
      ActualShippingDate
      AwaitingDispatch
      OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      PaidAmount
      TotalAmount
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


