import gql from 'graphql-tag'; 

export const GET_USERS = gql`
query getUsers {
  erp_Users{
    FirstName
    LastName
    UserID
  }
}
`