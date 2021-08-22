import {gql} from 'graphql-tag'; 

export const MUTATE_CHECKLIST_UNIT = gql`
mutation MyMutation($CheckListUnitID: Int!, $IsCompluted: Boolean!) {
  update_erp_CheckListUnits_by_pk(pk_columns: {CheckListUnitID: $CheckListUnitID}, _set: {IsComplited: $IsCompluted}) {
    CheckListUnitID
    IsComplited
    Point
  }
}
`