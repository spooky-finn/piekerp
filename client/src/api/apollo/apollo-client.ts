import { ApolloClient, InMemoryCache, from } from '@apollo/client'
import { webSocketLink, wsErrorLink, wsRetryLink } from './apollo-ws-links'

export const apolloClient = new ApolloClient({
  link: from([wsRetryLink, wsErrorLink, webSocketLink]),
  cache: new InMemoryCache({
    typePolicies: {
      erp_Orders: {
        keyFields: ['OrderID']
      },
      erp_CheckListUnits: {
        keyFields: ['CheckListUnitID']
      },
      erp_Comments: {
        keyFields: ['CommentID']
      },
      erp_Docs: {
        keyFields: ['ID']
      },
      erp_PaymentHistory: {
        keyFields: ['ID']
      }
    }
  })
})
