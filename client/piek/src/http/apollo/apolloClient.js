import {
  ApolloClient,
  InMemoryCache,
  from,
} from "@apollo/client";
import { split } from '@apollo/client';
import { getMainDefinition } from '@apollo/client/utilities';

import { wsRetryLink, wsErrorLink, webSocketLink } from './wsLinks';
import { httpErrorLink, httpAuthLink, httpLink } from './httpLinks';


const splitLink = split(
  ({ query }) => {
    const definition = getMainDefinition(query);

    return (
      definition.kind === 'OperationDefinition' &&
      definition.operation === 'subscription'
    );
  },
  from([ wsRetryLink, wsErrorLink, webSocketLink ]),
  from([ httpErrorLink, httpAuthLink, httpLink ]),
);

export const apolloClient = new ApolloClient({
  link:  splitLink,
  cache: new InMemoryCache({
    typePolicies: {
        erp_Orders: {
          keyFields: ["OrderID"],
        },
        erp_CheckListUnits: {
          keyFields: ['CheckListUnitID']
        },
        erp_Comments: {
          keyFields: ['CommentID']
        }
    },
  })
})
