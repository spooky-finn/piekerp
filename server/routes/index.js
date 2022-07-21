var express = require('express');
var router = express.Router();

const userController = require('../controllers/user-controller');
const S3Controller = require('../controllers/s3-controller');

const { body } = require('express-validator');
const authMiddleware = require('../middlewares/auth-middleware');
const multerMiddleware = require('../middlewares/multer-middleware');
const orderController = require('../controllers/order-controller');

router.post('/login', body('email').isEmail(), userController.login);
router.post('/logout', userController.logout);
router.get('/refresh', userController.refresh);

// Yandex Cloud Object Storage

// Upload
router.put('/s3', [multerMiddleware, S3Controller.uploadBinaryFiles]);
// GetFile
router.get('/s3/:key', S3Controller.getBinaryFile);
// DeleteFile
router.delete('/s3/:key', authMiddleware, S3Controller.removeSingleFile)


router.get('/backup/:key', S3Controller.getHasuraBackup)

router.get('/orders/unpaid', orderController.getUnpaidOrders)

module.exports = router;