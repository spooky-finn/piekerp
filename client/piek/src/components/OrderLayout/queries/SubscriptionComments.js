import gql from 'graphql-tag'

export const SUBSCRIBTION_ORDER_COMMENT = gql`
  subscription MySubscritp($OrderID: Int!) {
    erp_Comments(where: {OrderID: {_eq: $OrderID}}, order_by: {CommentID: desc}) {
      CommentID
      Text
      Timestamp
      User {
        UserID
        FirstName
        LastName
      }
    }
  }
`
