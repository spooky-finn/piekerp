import gql from 'graphql-tag'; 

// Выбираем заказы находящиеся только в Прездаказах и в производстве 
//   OrderStatusID 
//     1 - В производстве
//     3- Предзаказ
//     4- Выпущен и отгружен
// 

export const GetOrdersSubscription = gql`
subscription GetOrders($search: String) {
    erp_Orders(where: {OrderStatusID: {_neq: 4} }) {
      OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      PaidAmount
      TotalAmount
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