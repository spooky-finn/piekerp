import { unescape } from 'querystring'
import { config } from '../config/config'
import { mainS3Client } from '../lib/s3-clients'

class S3Service {
  async deleteObject(key: string, bucket: string) {
    const params = { Bucket: bucket, Key: key }

    return mainS3Client.deleteObject(params, function (err, data) {
      if (err) throw new Error(`Could not delete file from S3: ${err.message}`)
      return data
    })
  }

  async getObject(key: string) {
    const params = { Bucket: config.S3_BUCKET, Key: key }

    try {
      const data = await mainS3Client.getObject(params).promise()
      data.Metadata.originalname = unescape(data.Metadata.originalname)
      return data
    } catch (e) {
      throw new Error(`Could not retrieve file from S3: ${e.message}`)
    }
  }
}

export default new S3Service()
