import {gql} from 'graphql-tag'; 

export const DELETE_ORDER = gql`
mutation MyMutation($OrderID: Int!) {
  delete_erp_Orders_by_pk(OrderID: $OrderID) {
    OrderID
  }
}
`;