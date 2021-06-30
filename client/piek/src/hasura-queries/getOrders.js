// import React, { useEffect, Fragment, useState } from "react";

// import { useMutation, useSubscription, gql } from "@apollo/client";

// import { ApolloClient, ApolloProvider, InMemoryCache } from '@apollo/client';
// import { WebSocketLink } from "@apollo/client/link/ws";

// const { loading, error, data } = getOrders(
//     gql`
//       subscription erp_Orders {
//         Entity
//         InvoiceNumber
//         City
//         OrderItems {
//           Quantity
//           OrderItemID
//           Name
//           OrderID
//         }
//       }
//     `
//   );

//   if (loading) {
//     return <span>Loading...</span>;
//   }
//   if (error) {
//     console.error(error);
//     return <span>Error!</span>;
//   }
//   if (data) {
//     onlineUsersList = data.online_users.map(u => (
//       <OnlineUser key={u.id} user={u.user} />
//     ));
//   }

//   return (
//     <div className="onlineUsersWrapper">
//       <Fragment>
//         <div className="sliderHeader">
//           Online users - {onlineUsersList.length}
//         </div>
//         {onlineUsersList}
//       </Fragment>
//     </div>
//   );
// };

// export default getOrders;
