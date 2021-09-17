import gql from 'graphql-tag'; 

// Выбираем заказы находящиеся только в Прездаказах и в производстве 
//   OrderStatusID 
//     1- Предзаказ
//     2 - В производстве
//     3- Выпущен и отгружен
// 

export const GetOrdersSubscription = gql`
subscription{
    erp_Orders(where: {OrderStatusID: {_neq: 3} }) {
      OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      AcceptanceDate
      PaidAmount
      TotalAmount
      AwaitingDispatch
      CreatingDate
      ManagerID
      OrderStatus {
        Name
        ID
      }
      OrderItems(order_by: {OrderItemID: asc}){
        Quantity
        OrderItemID
        Name
        OrderID
      } 
      User {
        FirstName
        LastName
      }

    }  
  }
`
