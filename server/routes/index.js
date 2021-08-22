var express = require('express');
var router = express.Router();

const userController = require('../controllers/user-controller');
const { body } = require('express-validator');
const authMiddleware = require('../middlewares/auth-middleware');

const  { upload, download, deleteObject }  = require('../S3/s3');


router.post('/login', body('email').isEmail(), userController.login);
router.post('/logout', userController.logout);
router.get('/refresh', userController.refresh);


// Yandex Cloud Object Storage
router.post('/s3/upload', upload.array('files', 20), (req, res) =>{
    res.send(req.files)
  });
router.get('/s3/get/:key', (req, res)=> {
  download(req.params.key, res);
});
router.get('/s3/delete/:key', (req, res) => {
  deleteObject(req.params.key);
  res.send()
})

module.exports = router;
