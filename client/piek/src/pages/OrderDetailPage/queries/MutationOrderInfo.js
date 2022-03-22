import {gql} from 'graphql-tag'; 

export const UPDATE_ORDER_INFO = gql`
 mutation MyMutation($OrderID: Int!, $fields: erp_Orders_set_input) {
  update_erp_Orders_by_pk(pk_columns: {OrderID: $OrderID}, _set: $fields) {
		OrderID
    Entity
    City
    CreatingDate
  }
}
`;

export const UPDATE_AWAITING_DISPATCH = gql`
 mutation MyMutation($OrderID: Int!, $AwaitingDispatch: Boolean!) {
  update_erp_Orders_by_pk(
    pk_columns: {OrderID: $OrderID},
   _set: { AwaitingDispatch: $AwaitingDispatch }
  ) {
		OrderID
    AwaitingDispatch
  }
}
`;
export const UPDATE_NEED_ATTENTION = gql`
mutation MyMutation($OrderID: Int!, $NeedAttention: String! ) {
  update_erp_Orders_by_pk(
    pk_columns: {OrderID: $OrderID},
   _set: { NeedAttention: $NeedAttention }
  ) {
		OrderID
    NeedAttention
  }
}
`

export const MOVE_ORDER_TO_ARCHIVE = gql`
  mutation MyMutation($OrderID: Int!, $ActualShippingDate: timestamp!, $OrderStatusID: Int!) {
    update_erp_Orders_by_pk(
      pk_columns: {OrderID: $OrderID}, 
      _set: {
        OrderStatusID: $OrderStatusID,
        AwaitingDispatch: false,
        ActualShippingDate: $ActualShippingDate,
        }){
      OrderID
      OrderStatusID
    }
  }
`;

export const MOVE_ORDER_TO_PRIORITY = gql`
    mutation MyMutation($OrderID: Int!, $AcceptanceDate: timestamp!){
    update_erp_Orders_by_pk(
      pk_columns: {OrderID: $OrderID},
       _set: {
         OrderStatusID: 2,
         AcceptanceDate: $AcceptanceDate,
         }
      ) {
        OrderID
        OrderStatusID
    }
  }

`;