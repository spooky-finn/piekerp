import { config } from '../config/config'
import { mainS3Client } from '../lib/s3-clients'

class S3Service {
  async deleteObject(key: string, bucket: string) {
    return mainS3Client
      .deleteObject({ Bucket: bucket, Key: key })
      .promise()
      .catch(err => {
        throw new Error(`Could not delete file from S3: ${err.message}`)
      })
  }

  async getObject(key: string) {
    try {
      return await mainS3Client.getObject({ Bucket: config.S3_BUCKET, Key: key }).promise()
    } catch (e) {
      throw new Error(`Could not retrieve file from S3: ${e.message}`)
    }
  }
}

export default new S3Service()
