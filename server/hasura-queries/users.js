const fetch = require("node-fetch");

class HasuraQuery {

  async getUsers() {
    let responseData = await fetch("http://45.10.110.58:8080/v1/graphql", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,
        },
        body: JSON.stringify({
            query: `{
                erp_Users {
                  UserID
                  FirstName
                  LastName
                  Email
                  Password
                  AccessLevel {
                    Name
                  }
                }
               }`
        })
      })
        .then(result => {
          return result.json();
          
        })
        .then(data=> {
        return data;
        });
    return responseData.data.erp_Users;
}

async getTokens() {
  let responseData = await fetch("http://45.10.110.58:8080/v1/graphql", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,
      },
      body: JSON.stringify({
          query: `{
            erp_Tokens {
              ID
              RefreshToken
              User {
                UserID
                FirstName
                LastName
                Email
              }
            }
             }`
      })
    })
      .then(result => {
        return result.json();
        
      })
      .then(data=> {
      return data;
      });
  return responseData.data.erp_Tokens;
}



async createToken(UserID, refreshToken) {
  var query = `mutation myMytation($UserID: Int!, $refreshToken: String!){
    insert_erp_Tokens(objects: {UserID: $UserID, RefreshToken: $refreshToken}) {
      returning {
        UserID
      }
    }
    }`;

  let responseData = await fetch("http://45.10.110.58:8080/v1/graphql", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,

      },
      body: JSON.stringify({
          query: query, 
          variables: {UserID, refreshToken},
      })
    })
      .then(result => result.json())
      .then(data=> data);
  return responseData.data.insert_erp_Tokens;
}

async deleteToken(refreshToken) {
  var query = `mutation myMytation($refreshToken: String!){
    delete_erp_Tokens(where: {RefreshToken: {_eq: $refreshToken}}) {
      returning {
        UserID
      }
    }
   }`;

  let responseData = await fetch("http://45.10.110.58:8080/v1/graphql", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,

      },
      body: JSON.stringify({
          query: query, 
          variables: {refreshToken},
      })
    })
      .then(result => result.json())
      .then(data=> data);
  return responseData.data.delete_erp_Tokens;
}


async updateToken(tokenID, refreshToken) {
    var query = `mutation myMytation($tokenID: Int!, $refreshToken: String!){
        update_erp_Tokens_by_pk(pk_columns: {ID: $tokenID}, _set: {RefreshToken: $refreshToken}) {
          ID
          UserID
        }
     }`;

    let responseData = await fetch("http://45.10.110.58:8080/v1/graphql", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,
        },
        body: JSON.stringify({
            query: query, 
            variables: {tokenID, refreshToken},
        })
      })
        .then(result => result.json())
        .then(data=> data);
    return responseData;
}

}
module.exports = new HasuraQuery();