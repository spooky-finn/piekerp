import gql from 'graphql-tag'; 

// Выбираем заказы находящиеся только в Прездаказах и в производстве 
//   OrderStatusID 
//     1- Предзаказ
//     2 - В производстве
//     3- Выпущен и отгружен
// 

export const GetOrdersSubscription = gql`
subscription GetOrders($search: String) {
    erp_Orders(where: {OrderStatusID: {_neq: 3} }) {
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
      OrderStatus {
        Name
        ID
      }
      OrderItems {
        Quantity
        OrderItemID
        Name
        OrderID
      } 
      User {
        FirstName
      }

    }  
  }
`
export const GET_USERS = gql`
query getUsers {
  erp_Users{
    FirstName
    LastName
    UserID
  }
}
`