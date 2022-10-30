import * as dotenv from 'dotenv'
dotenv.config({ path: `../.env` })

import multer from 'multer'
import multerS3, { AUTO_CONTENT_TYPE } from 'multer-s3'
import uuidv4 from 'uuid/v4'
import { escape } from 'querystring'
import awsClient from '../lib/s3-client'

const multerMiddleware = multer({
  storage: multerS3({
    s3: awsClient,
    bucket: process.env.S3_BUCKET,
    storageClass: 'COLD',
    contentType: AUTO_CONTENT_TYPE,
    metadata: (req, file, cb) => {
      cb(null, {
        originalname: escape(file.originalname)
      })
    },
    key: function (req, file, cb) {
      //generate unique file names to be saved on the server
      cb(null, uuidv4())
    }
  })
}).array('files', 20)

export default multerMiddleware
