import gql from 'graphql-tag'; 

export const UPDATE_TIME_DEDUCTION = gql`
mutation MyMutation( $TimeDeduction: numeric!, $ID: Int! ) {
    update_attendance_config_by_pk(pk_columns: {ID: $ID}, _set: {TimeDeduction: $TimeDeduction}) {
      TimeDeduction
      ID
    }
}
`

