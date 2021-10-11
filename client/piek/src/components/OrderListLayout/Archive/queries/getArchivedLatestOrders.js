import { gql } from "graphql-tag"

export const GET_ARCHIVED_LATEST_ORDERS = gql`
query($limit: Int!){
  erp_Orders(
    where: { OrderStatusID: {_eq: 3} } 
    limit: $limit
    ){
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