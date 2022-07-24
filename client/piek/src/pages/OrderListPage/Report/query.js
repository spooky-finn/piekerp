import gql from 'graphql-tag';

export const GET_ORDERS_BY_INTERVAL = gql`
query MyQuery($_lte: timestamp!, $_gte: timestamp!) {
    erp_Orders(where: {ActualShippingDate: {_lte: $_lte, _gte: $_gte}}, order_by: { ActualShippingDate: asc}) {
    AcceptanceDate
    ActualShippingDate
    CheckListTPLID
    City
    Comment
    Entity
    InvoiceNumber
    IsReclamation
    TotalAmount
    ManagerID
    NeedAttention
    OrderNumber
    PaidAmount
    ShippingDate
    OrderID
    OrderStatusID
    User {
      FirstName
    }
    OrderItems(order_by: {OrderItemID: asc}){
        Quantity
        OrderItemID
        Name
        OrderID
      } 
  }
}
`