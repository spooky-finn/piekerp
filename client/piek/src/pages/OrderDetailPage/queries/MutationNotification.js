import {gql} from 'graphql-tag'; 

export const INSERT_NOTIFICATION = gql`
mutation($CommentID: Int!, $MentionedUser: Int!, $OrderID: Int!){
  insert_erp_Notifications(objects: 
    { CommentID: $CommentID, MentionedUser: $MentionedUser, OrderID: $OrderID }
    ){
    returning {
      MentionedUser
      ID
    }
  }
}
`;


