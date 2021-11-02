import { gql } from "graphql-tag"

export const GET_ARCHIVED_LATEST_ORDERS = gql`
query($limit: Int!, $OrderStatus: Int!){
  erp_Orders(
    order_by: {ActualShippingDate: desc_nulls_last}
    where: { OrderStatusID: {_eq: $OrderStatus } } 
    limit: $limit
    ){
    ActualShippingDate
    ShippingDate
    AwaitingDispatch
    OrderID
    Entity
    InvoiceNumber
    City
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