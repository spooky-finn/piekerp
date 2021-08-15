import {gql} from 'graphql-tag'; 

export const PUSH_DOCS_ARRAY = gql`
mutation MyMutation($objects: [erp_Docs_insert_input!]!) {
  insert_erp_Docs(objects: $objects) {
    returning {
      DocID
    }
  }
}
`