import {gql} from 'graphql-tag'; 

export const INSERT_ORDER = gql`
mutation MyMutation($managerID: Int!, $orderStatusID: Int!) {
  insert_erp_Orders(objects: {ManagerID: $managerID, OrderStatusID:  $orderStatusID}) {
    returning {
      OrderID
    }
  }
}
`;