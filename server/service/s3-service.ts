import awsClient from '../lib/s3-client'
import { unescape } from 'querystring'

class S3Service {
  async deleteObject(key: string, bucket: string) {
    const params = { Bucket: bucket, Key: key }

    return awsClient.deleteObject(params, function (err, data) {
      if (err) throw new Error(`Could not delete file from S3: ${err.message}`)
      return data
    })
  }

  async getObject(key: string) {
    const params = { Bucket: process.env.S3_BUCKET, Key: key }

    try {
      const data = await awsClient.getObject(params).promise()
      data.Metadata.originalname = unescape(data.Metadata.originalname)
      return data
    } catch (e) {
      throw new Error(`Could not retrieve file from S3: ${e.message}`)
    }
  }
}

export default new S3Service()
