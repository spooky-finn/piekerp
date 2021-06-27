var express = require('express');
var router = express.Router();
const fetch = require("node-fetch");

/* GET users listing. */
router.get('/', function(req, res, next) {
  fetch("http://45.10.110.168:8080/v1/graphql", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      query: `{
        erp_Users {
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
      data = data.data.erp_Users
      // let d = data.find(el => el.FirstName === "Иван");
      // console.log("data returned:\n", data);
      res.send(data);
    });

});

module.exports = router;
