import gql from 'graphql-tag';

export const GET_USERS = gql`
query getUsers {
  erp_Users(where: {AccessLevel: {AccessLevelID: {_lte: 2}}}) {
    FirstName
    LastName
    UserID
    AccessLevelID
  }
}
`