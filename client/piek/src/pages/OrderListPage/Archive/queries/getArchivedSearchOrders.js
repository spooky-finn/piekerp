import { gql } from "graphql-tag"

export const GET_ARCHIVED_SEARCH_ORDERS = gql`
    query ($keyword: String!, $OrderStatus: Int!){
    erp_Orders(
      order_by: {ActualShippingDate: desc_nulls_last},
      where: {
      _or: [
        { Entity: {_ilike: $keyword} }, 
        { InvoiceNumber: {_ilike: $keyword} },
        { OrderItems: {_and: [{SerialStarts: {_lte: $keyword}}, {SerialEnds: {_gte: $keyword }}] } },

        ],
      OrderStatusID: {_eq: $OrderStatus}
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


