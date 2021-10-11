import {gql} from 'graphql-tag'; 

export const INSERT_PAYMENT = gql`
  mutation($PaidAmount: numeric!, $Date: timestamptz!, $OrderID: Int!) {
    insert_erp_PaymentHistory_one(object: {PaidAmount: $PaidAmount, OrderID: $OrderID, Date: $Date}) {
      ID
      OrderID
    }
}
`;