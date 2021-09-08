import {gql} from 'graphql-tag'; 

export const UPDATE_ORDER_INFO = gql`
 mutation MyMutation($orderID: Int!, $fields: erp_Orders_set_input) {
  update_erp_Orders_by_pk(pk_columns: {OrderID: $orderID}, _set: $fields) {
		OrderID
  }
}
`;

export const UPDATE_AWAITING_DISPATCH = gql`
 mutation MyMutation($orderID: Int!, $awaitingDispatch: Boolean!) {
  update_erp_Orders_by_pk(
    pk_columns: {OrderID: $orderID},
   _set: { AwaitingDispatch: $awaitingDispatch }
  ) {
		OrderID
    AwaitingDispatch
  }
}
`;