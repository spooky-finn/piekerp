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
      intervals(where: {ent: {_gte: $gte,  _lte: $lte}}) {
        id 
        ent
        ext
        card
      }
    }
  }
  attendance_config {
    TimeDeduction
  }
}  
`


