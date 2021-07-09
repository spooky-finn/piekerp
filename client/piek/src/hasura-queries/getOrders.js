import gql from 'graphql-tag'; 



// Выбираем заказы находящиеся только в Прездаказах и в производстве 
//   OrderStatusID 
//     1 - В производстве
//     3- Предзаказ
//     4- Выпущен и отгружен
// 

export const GetOrdersSubscription = gql`
subscription GetOrders {
    erp_Orders(where: {OrderStatusID: {_neq: 4}}) {
      OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      PaidAmount
      TotalAmount
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
      
    }
  }

`