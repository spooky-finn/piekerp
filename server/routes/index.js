var express = require('express');
var router = express.Router();
var {ApolloClient} = require('apollo-client');
var {InMemoryCache} = require('apollo-cache-inmemory');
var {gql} = require('graphql-tag');
var {useQuery} = require('apollo-client');

const userController = require('../controllers/user-controller');
const orderController = require('../controllers/order-controller');

const {body} = require('express-validator');
const authMiddleware = require('../middlewares/auth-middleware');
/* GET home page. */
// router.get('/', function(req, res, next) {
//   new ApolloClient({
//     link: 'http://45.10.110.168:8080/v1/graphql',
//     cache: new InMemoryCache(),
//   });
//   const GET_USER = gql ` query MyQuery {
//     erp_Users {
//       Login
//       FirstName
//       LastName
//       Password
//     }
//   }
//   `
//   const {
//     data,
//     loading,
//     error
//   } = useQuery(GET_USER)

//   console.log('привет!', data );
//   res.render('index', { title: 'Express' });
// });

router.post('/login', body('email').isEmail(), userController.login);
router.post('/logout', userController.logout);
router.get('/refresh', userController.refresh);
router.get('/users', authMiddleware, userController.getUsers);

// router.get('/fulfillment', orderController.fulfillment);
// router.get('/newest', orderController.newest);

module.exports = router;
