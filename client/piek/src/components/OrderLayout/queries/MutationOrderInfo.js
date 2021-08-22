import {gql} from 'graphql-tag'; 

export const UPDATE_ORDER_INFO = gql`
 mutation MyMutation($fields: erp_Orders_set_input, $orderID: Int!) {
  update_erp_Orders_by_pk(pk_columns: {OrderID: $orderID}, _set: $fields) {
		OrderID
  }
}
`;