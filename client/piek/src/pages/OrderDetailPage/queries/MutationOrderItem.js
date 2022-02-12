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

export const DELETE_ORDER_ITEM = gql`
mutation MyMutation($orderItemID: Int!) {
  delete_erp_OrderItems_by_pk(OrderItemID: $orderItemID) {
		OrderItemID
  }
}
`;


export const UPDATE_ORDER_ITEM = gql`
mutation($OrderItemID: Int!, $FullName: String!, $Name: String!, $Quantity: Int!) {
  update_erp_OrderItems_by_pk(
    pk_columns: {OrderItemID: $OrderItemID},
    _set: {FullName: $FullName, Name: $Name, Quantity: $Quantity}) {
    Name
    FullName
    OrderItemID
    Quantity
  }
}

`;
export const UPDATE_ORDER_ITEM_METADATA = gql`
mutation($OrderItemID: Int!, $Fitter: String!, $SerialNumber: String!) {
  update_erp_OrderItems_by_pk(
    pk_columns: {OrderItemID: $OrderItemID},
     _set: {Fitter: $Fitter, SerialNumber: $SerialNumber}
  ){
    OrderItemID
  }
}
`