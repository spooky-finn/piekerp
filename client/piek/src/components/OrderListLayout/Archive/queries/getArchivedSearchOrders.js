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
    OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      PaidAmount
      TotalAmount
      AwaitingDispatch
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


