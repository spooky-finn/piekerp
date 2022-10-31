import { Router } from 'express'
import { body } from 'express-validator'
import authMiddleware from '../middlewares/auth-middleware'
import multerMiddleware from '../middlewares/multer-middleware'
import { OrderController, UserController, S3Controller } from '../controllers/'

export const router = Router()

router.post('/login', body('email').isEmail(), UserController.login)
router.post('/logout', UserController.logout)
router.get('/refresh', UserController.refresh)

// Yandex Cloud Object Storage

// Upload
router.put('/s3', [multerMiddleware, S3Controller.uploadBinaryFiles])
// GetFile
router.get('/s3/:key', S3Controller.getBinaryFile)
// DeleteFile
router.delete('/s3/:key', authMiddleware, S3Controller.removeSingleFile)

router.get('/backup/:key', S3Controller.getHasuraBackup)

router.get('/orders/unpaid', OrderController.getUnpaidOrders)
