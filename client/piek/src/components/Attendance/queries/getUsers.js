import gql from 'graphql-tag'; 

export const GET_USERS = gql`
query MyQuery($gte: timestamp!, $lte: timestamp!) {
  attendance_users_aggregate(
    order_by: {lastname: asc}
    ){
    nodes {
      id
      card
      firstname
      lastname
      intervalsPools(where: {entrance: {_gte: $gte,  _lte: $lte}}) {
        entrance
        exit
        card
        interval
        status
      }
    }
  }
}  
`


