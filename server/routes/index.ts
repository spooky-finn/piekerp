import { Router } from 'express'
import userController from '../controllers/user-controller'
import S3Controller from '../controllers/s3-controller'
import { body } from 'express-validator'
import authMiddleware from '../middlewares/auth-middleware'
import multerMiddleware from '../middlewares/multer-middleware'
import orderController from '../controllers/order-controller'

export const router = Router()

router.post('/login', body('email').isEmail(), userController.login)
router.post('/logout', userController.logout)
router.get('/refresh', userController.refresh)

// Yandex Cloud Object Storage

// Upload
router.put('/s3', [multerMiddleware, S3Controller.uploadBinaryFiles])
// GetFile
router.get('/s3/:key', S3Controller.getBinaryFile)
// DeleteFile
router.delete('/s3/:key', authMiddleware, S3Controller.removeSingleFile)

router.get('/backup/:key', S3Controller.getHasuraBackup)

router.get('/orders/unpaid', orderController.getUnpaidOrders)
