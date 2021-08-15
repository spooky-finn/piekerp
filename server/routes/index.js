var express = require('express');
var router = express.Router();

const userController = require('../controllers/user-controller');
const { body } = require('express-validator');
const authMiddleware = require('../middlewares/auth-middleware');

const  { upload }  = require('../S3/s3');
const { download }  =require('../S3/s3')


router.post('/login', body('email').isEmail(), userController.login);
router.post('/logout', userController.logout);
router.get('/refresh', userController.refresh);

router.post('/s3/upload', upload.array('files', 10), (req, res) =>{
    res.send(req.files)
  });

router.get('/s3/get/:key',(req,res)=>{
  download(req.params.key, res);
});

module.exports = router;
