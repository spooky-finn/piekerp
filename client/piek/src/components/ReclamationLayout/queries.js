import gql from 'graphql-tag'; 

// Выбираем заказы находящиеся только в Прездаказах и в производстве 
//   OrderStatusID 
//     1- Предзаказ
//     2 - В производстве
//     3- Выпущен и отгружен
// 

export const SUBSCRIPTION_RECLAMATION_ORDERS = gql`
subscription{
    erp_Orders(where: {OrderStatusID: {_in: [10,11,12]} }) {
      AwaitingDispatch
      NeedAttention
      OrderID
      Entity
      City
      OrderStatusID
      OrderItems(order_by: {OrderItemID: asc}){
        OrderItemID
        Name
      }   
    }  
  }
`

export const UPDATE_ORDER_STATUS = gql`
    mutation MyMutation($OrderID: Int!, $OrderStatusID: Int!){
    update_erp_Orders_by_pk(
      pk_columns: {OrderID: $OrderID},
       _set: {
         OrderStatusID: $OrderStatusID,
         }
      ) {
        OrderID
        OrderStatusID
    }
  }

`;

export const INSERT_ORDER = gql`
mutation MyMutation($managerID: Int, $orderStatusID: Int!) {
  insert_erp_Orders(objects: {ManagerID: $managerID, OrderStatusID:  $orderStatusID}) {
    returning {
      OrderID
    }
  }
}
`;