import {gql} from 'graphql-tag'; 

//   OrderStatusID 
//     1 - В производстве
//     3- Предзаказ
//     4- Выпущен и отгружен
// 

export const ChangeOrderStatus = gql`
    mutation MyMutation($OrderID: Int!, $OrderStatus: Int!){
    update_erp_Orders_by_pk(pk_columns: {OrderID: $OrderID}, _set: {OrderStatusID: $OrderStatus}) {
        OrderID
    }
  }

`;