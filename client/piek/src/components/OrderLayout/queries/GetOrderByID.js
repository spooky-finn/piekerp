import gql from 'graphql-tag'

export const GET_ORDER_BY_ID = gql`
query MyQuery($OrderID: Int!) {
  erp_Orders(
    where: {OrderID: {_eq: $OrderID}}
    ){
    City
    CreatingDate
    Comment
    Entity
    InvoiceNumber
    ManagerID
    OrderID
    OrderNumber
    OrderStatusID
    PaidAmount
    ShipmentComment
    ShippingDate
    TotalAmount
    IsReclamation
    AwaitingDispatch
    User {
      FirstName
      LastName
      UserID
    }
    OrderItems {
      Fitter
      Name
      FullName
      OrderItemID
      OrderID
      Quantity
      SerialNumber
    }
    CheckListUnits {
      IsComplited
      OrderID
      Point
      CheckListUnitID
    }
    Docs {
      Key
      FileName
    }
  }
}
`