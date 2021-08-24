import {gql} from 'graphql-tag'; 

export const INSERT_ORDER = gql`
mutation MyMutation($managerID: Int!, $orderStatusID: Int!, $isReclamation: Boolean!) {
  insert_erp_Orders(objects: {ManagerID: $managerID, OrderStatusID:  $orderStatusID, IsReclamation: $isReclamation}) {
    returning {
      OrderID
    }
  }
}
`;