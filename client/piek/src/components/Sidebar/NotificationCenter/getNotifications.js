import gql from 'graphql-tag'; 

export const GET_NOTIFICATIONS = gql`
subscription MyQuery($_eq: Int!, $limit: Int) {
  erp_Notifications(where: {MentionedUser: {_eq: $_eq}}, limit: $limit, order_by: {ID: desc} ) {
    ID
    Viewed
    Comment {
      CommentID
      Text
      Timestamp
      User {
        UserID
        FirstName
        LastName
      }
    }
    Order {
      OrderID
      City
      Entity
    }
  }
}
`
export const UPDATE_VIEWED = gql`
mutation($ID: Int!, $Viewed: Boolean!) {
  update_erp_Notifications_by_pk(pk_columns: {ID: $ID}, _set: {Viewed: $Viewed}){
    ID
    Viewed
  }
}
`

