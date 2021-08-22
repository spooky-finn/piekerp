import {gql} from 'graphql-tag'; 

export const INSERT_ORDER_ITEM = gql`
 mutation MyMutation($name: String!, $orderID: Int!, $quantity: Int!) {
  insert_erp_OrderItems_one(object: {Name: $name, OrderID: $orderID, Quantity: $quantity}) {
    OrderItemID
    OrderID
  }
}
`;