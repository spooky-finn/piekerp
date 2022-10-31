import ApiError from '../exceptions/api-error'
import { NextFunction, Request, Response } from 'express'
import hasuraS3Service from '../service/hasura-s3-service'
import S3Service from '../service/s3-service'
import { backupS3Client } from '../lib/S3Clients'
import { config } from '../config/config'

class S3Controller {
  async removeSingleFile(req: Request, res: Response, next: NextFunction) {
    /**
     * Incoming request must contain a 'orderid'(integer) parameter in request headers.
     * The `Request` object will be populated with a `files` object containing
     * information about the processed file.
     *
     * hasuraUpload method adds file metadata into database using graphql server.
     */
    try {
      const key = req.params.key
      const data = await S3Service.deleteObject(key, config.S3_BUCKET).then(async s3_responce => {
        return await hasuraS3Service.removeFileInformation(key)
      })

      res.json(data)
    } catch (error) {
      next(error)
    }
  }

  async uploadBinaryFiles(req: Request & { files: any[] }, res: Response, next: NextFunction) {
    /**
     * Incoming request must contain a 'orderid'(integer) parameter in request headers.
     * The `Request` object will be populated with a `files` object containing
     * information about the processed file.
     *
     * hasuraUpload method adds file metadata into database using graphql server.
     */
    try {
      const array_of_files = req.files.map(each => ({
        Key: each.key,
        OrderID: req.headers.orderid,
        FileName: each.originalname,
        Size: each.size
      }))

      const data = await hasuraS3Service.addFileInformation(array_of_files)
      res.send(data)
    } catch (error) {
      next(error)
    }
  }

  async getBinaryFile(req: Request, res: Response, next: NextFunction) {
    try {
      const data = await S3Service.getObject(req.params.key)
      const fileName = encodeURI(data.Metadata.originalname)
      res.set('Content-Type', data.ContentType)
      res.set('Content-Disposition', `inline;filename*=utf-8''${fileName}`)
      res.send(data.Body)
    } catch (error) {
      next(error)
    }
  }

  async getHasuraBackup(req: Request, res: Response, next: NextFunction) {
    try {
      const hasuraAdminSectret = req.query.hasura_admin_secret
      const key = req.params.key

      if (!hasuraAdminSectret) throw ApiError.BadRequest('query-didnt-contain-hasura_admin_secret')

      if (hasuraAdminSectret != config.HASURA_ADMIN_SECRET)
        throw ApiError.BadRequest('wrong-hasura_admin_secret-in-query')

      const data = await backupS3Client
        .getObject({
          Bucket: config.S3_BACKUP_SERVICE_BUCKET,
          Key: key,
          ResponseContentEncoding: 'utf-8'
        })
        .promise()

      res.set('Content-Type', 'text/plain')
      res.set('Content-Disposition', `attachment; filename="db_dump.sql"`)

      return res.json(data.Body.toString('utf-8'))
    } catch (error) {
      next(error)
    }
  }
}

export default new S3Controller()
