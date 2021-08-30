import {gql} from 'graphql-tag'; 

export const INSERT_ORDER_ITEM = gql`
 mutation MyMutation($name: String!, $orderID: Int!, $quantity: Int!, $fullName: String!) {
  insert_erp_OrderItems_one(object: {
    OrderID: $orderID,
    Name: $name,
    FullName: $fullName,
    Quantity: $quantity,
    }) {
    OrderItemID
    OrderID
  }
}
`;