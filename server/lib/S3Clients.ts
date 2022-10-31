import AWS from 'aws-sdk'
import { config } from '../config/config'

export const backupS3Client = new AWS.S3({
  accessKeyId: process.env.S3_BACKUP_SERVICE_ACCESS_KEY_ID,
  secretAccessKey: process.env.S3_BACKUP_SERVICE_SECRET_ACCESS_KEY,
  endpoint: process.env.S3_ENDPOINT,
  s3ForcePathStyle: true,
  signatureVersion: 'v4'
})

export const mainS3Client = new AWS.S3({
  accessKeyId: config.S3_ACCESS_KEY_ID,
  secretAccessKey: config.S3_SECRET_ACCESS_KEY,
  endpoint: config.S3_ENDPOINT,
  s3ForcePathStyle: true,
  signatureVersion: 'v4'
})
