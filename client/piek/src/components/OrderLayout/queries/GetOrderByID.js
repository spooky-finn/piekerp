import gql from 'graphql-tag'

export const GET_ORDER_BY_ID = gql`
query MyQuery($OrderID: Int!) {
  erp_Orders(
    where: {OrderID: {_eq: $OrderID}}
    ){
    OrderID
    ManagerID
    OrderStatusID
    City
    ShippingDate
    CreatingDate
    Comment
    Entity
    InvoiceNumber
    OrderNumber
    PaidAmount
    TotalAmount
    AwaitingDispatch
    User {
      FirstName
      LastName
      UserID
    }
    OrderItems(order_by: {OrderItemID: asc}) {
      Fitter
      Name
      FullName
      OrderItemID
      OrderID
      Quantity
      SerialNumber
    }
    CheckListUnits(order_by: {CheckListUnitID: desc}) {
      CheckListUnitID
      OrderID
      IsComplited
      Point
    }
    Docs {
      Key
      FileName
    }
  }
}
`