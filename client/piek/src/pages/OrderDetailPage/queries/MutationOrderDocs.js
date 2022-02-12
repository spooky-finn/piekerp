import {gql} from 'graphql-tag'; 

export const PUSH_DOCS_ARRAY = gql`
mutation MyMutation($objects: [erp_Docs_insert_input!]!) {
  insert_erp_Docs(objects: $objects) {
    returning {
      ID
    }
  }
}
`;

export const DELETE_ORDER_FILE = gql`
    mutation MyMutation($key: String!) {
    delete_erp_Docs(where: {Key: {_eq: $key} }) {
        returning {
        Key
        }
    }
    }
`;