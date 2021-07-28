import gql from 'graphql-tag'

export const GET_ORDER_BY_ID = gql`
query MyQuery($OrderID: Int!) {
  erp_Orders(where: {OrderID: {_eq: $OrderID}}) {
    City
    CreatingDate
    Comment
    Entity
    InvoiceNumber
    IsReclamation
    ManagerID
    OrderID
    OrderNumber
    OrderStatusID
    PaidAmount
    ShipmentComment
    ShippingDate
    TotalAmount
    User {
      FirstName
      LastName
      UserID
    }
    OrderItems {
      Fitter
      Name
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
  }
}
`