import gql from 'graphql-tag'

export const GET_ALL_USERS = gql`
query MyQuery {
  erp_Users {
    FirstName
    LastName
    UserID
  }
}

`
