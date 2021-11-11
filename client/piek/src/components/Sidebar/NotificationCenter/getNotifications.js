import gql from 'graphql-tag'; 

export const GET_NOTIFICATIONS = gql`
subscription MyQuery($_eq: Int!, $limit: Int) {
  erp_Notifications(where: {MentionedUser: {_eq: $_eq}}, limit: $limit) {
    ID
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

