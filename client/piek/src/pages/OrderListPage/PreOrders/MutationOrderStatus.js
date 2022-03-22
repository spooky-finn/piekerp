import {gql} from 'graphql-tag'; 

//   OrderStatusID 
//     1- Предзаказ
//     2 - В производстве
//     3- Выпущен и отгружен
// 

export const MUTATE_ORDER_STATUS = gql`
    mutation MyMutation($OrderID: Int!, $AcceptanceDate: timestamp!){
    update_erp_Orders_by_pk(
      pk_columns: {OrderID: $OrderID},
       _set: {
         OrderStatusID: 2,
         AcceptanceDate: $AcceptanceDate,
         }
      ) {
        OrderID
    }
  }

`;