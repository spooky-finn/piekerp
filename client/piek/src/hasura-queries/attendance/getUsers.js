import gql from 'graphql-tag'; 

export const GET_USERS = gql`
query MyQuery {
    attendance_users(limit: 2) {
      id
      card
      firstname
      lastname
      intervalsPools {
        entrance
        exit
        card
        interval
        status
      }
    }
  }  
`