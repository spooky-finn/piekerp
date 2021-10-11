import {gql} from 'graphql-tag'; 

export const INSERT_ORDER_COMMENT = gql`
mutation($OrderID: Int!, $Text: String!, $UserID: Int!) {
  insert_erp_Comments_one(
    object: {OrderID: $OrderID, Text: $Text, UserID: $UserID}) 
    {
    CommentID
    OrderID
    Text
    Timestamp
    UserID
  }
}
`;

export const DELETE_ORDER_COMMENT = gql`
 mutation($CommentID: Int!) {
  delete_erp_Comments_by_pk(CommentID: $CommentID) {
    CommentID
  }
}
`;

export const UPDATE_ORDER_COMMENT = gql`
mutation($CommentID: Int!, $Text: String!, $Timestamp: timestamptz!) {
  update_erp_Comments_by_pk(
    pk_columns: {CommentID: $CommentID},
    _set: {Text: $Text, Timestamp: $Timestamp}) 
    {
    OrderID
    Text
    Timestamp
    UserID
    CommentID
  }
  }
`;