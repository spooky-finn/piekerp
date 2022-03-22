import gql from 'graphql-tag'

export const GET_ORDER_BY_ID = gql`
query MyQuery($OrderID: Int!) {
  erp_Orders(
    where: {OrderID: {_eq: $OrderID}}
    ){
    # visual statuses
    NeedAttention
    AwaitingDispatch
    OrderStatusID

    # dates
    ActualShippingDate
    AcceptanceDate
    ShippingDate
    CreatingDate

    OrderID
    ManagerID
    
    City
    
    Comment
    Entity
    InvoiceNumber
    
    OrderNumber
    User {
      FirstName
      LastName
      UserID
    }
    OrderItems(order_by: {OrderItemID: asc}) {
      Name
      FullName
      OrderItemID
      Quantity
    }
    Docs {
      Key
      FileName
    }

    # finances
    PaidAmount
    TotalAmount
    PaymentHistories(
      where: {PaidAmount: {_neq: 0}}
    ){
      PaidAmount
      Date
    }

  }
}
`