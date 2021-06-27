import {ApolloClient} from 'apollo-client';
import {InMemoryCache} from 'apollo-cache-inmemory';

export default new ApolloClient({
    link: concat(middlewareLink, link),
    cache: new InMemoryCache(),
    defaultHttpLink: false,
    defaultOptions: {
      query: {
        fetchPolicy: 'no-cache',
      },
      watchQuery: {
        fetchPolicy: 'no-cache'
      }
    }
  });