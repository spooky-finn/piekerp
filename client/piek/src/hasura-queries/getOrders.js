import gql from 'graphql-tag'; 

// Выбираем заказы находящиеся только в Прездаказах и в производстве 
//   OrderStatusID 
//     1 - В производстве
//     3- Предзаказ
//     4- Выпущен и отгружен
// 

export const GetOrdersSubscription = gql`
subscription GetOrders($search: String) {
    erp_Orders(where: {OrderStatusID: {_neq: 4},
      _or: [
        {Entity: {_ilike: $search } },
        {InvoiceNumber: {_ilike: $search} }
        ] }) {
      OrderID
      Entity
      InvoiceNumber
      City
      ShippingDate
      PaidAmount
      TotalAmount
      CreatingDate
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