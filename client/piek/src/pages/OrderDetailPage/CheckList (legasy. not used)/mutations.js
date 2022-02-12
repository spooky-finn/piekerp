import {gql} from 'graphql-tag'; 

export const INSERT_UNIT = gql`
mutation($OrderID: Int!, $Point: String!) {
  insert_erp_CheckListUnits_one(
    object: {OrderID: $OrderID, Point: $Point}){
      CheckListUnitID
      Point
      IsComplited
    }
}
`

export const UPDATE_UNIT_STATE = gql`
mutation MyMutation($CheckListUnitID: Int!, $IsCompluted: Boolean!) {
  update_erp_CheckListUnits_by_pk(
    pk_columns: {CheckListUnitID: $CheckListUnitID}, _set: {IsComplited: $IsCompluted})
    {
    CheckListUnitID
    IsComplited
    Point
    }
}
`