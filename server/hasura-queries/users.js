const fetch = require("node-fetch");

class HasuraQuery {

  async getUsers() {
    let responseData = await fetch("http://45.10.110.168:8080/v1/graphql", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
            query: `{
                erp_Users {
                  UserID
                  FirstName
                  LastName
                  Email
                  Password
                  RefreshToken
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
          // let d = data.find(el => el.FirstName === "Иван");
        //   console.log("data returned:\n", data);
        return data;
        });
    return responseData.data.erp_Users;
}


async updateToken(UserID, refreshToken) {
    var query = `mutation myMytation($UserID: Int!, $refreshToken: String!){
      update_erp_Users(where: {UserID: {_eq: $UserID}}, _set: {RefreshToken: $refreshToken}) {
          returning {
            UserID
          }
        }
     }`;

    let responseData = await fetch("http://45.10.110.168:8080/v1/graphql", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: JSON.stringify({
            query: query, 
            variables: {UserID, refreshToken},
        })
      })
        .then(result => result.json())
        .then(data=> data);
    return responseData;
}
}
module.exports = new HasuraQuery();