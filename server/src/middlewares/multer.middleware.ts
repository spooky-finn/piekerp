import multer from 'multer'
import multerS3, { AUTO_CONTENT_TYPE } from 'multer-s3'
import uuidv4 from 'uuid/v4'
import { config } from '../config/config'
import { mainS3Client } from '../lib/s3-clients'

const multerMiddleware = multer({
  storage: multerS3({
    s3: mainS3Client,
    bucket: config.S3_BUCKET,
    storageClass: 'COLD',
    contentType: AUTO_CONTENT_TYPE,
    key: function (req, file, cb) {
      //generate unique file names to be saved on the server
      cb(null, uuidv4())
    }
  })
}).array('files', 20)

export default multerMiddleware
