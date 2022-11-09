import { NextFunction, Request, Response } from 'express'
import { config } from '../config/config'
import ApiError from '../exceptions/api.error'
import { StaticStringKeys } from '../lib/constants'
import { database } from '../lib/graphql-client'
import { backupS3Client } from '../lib/s3-clients'
import S3Service from '../service/s3.service'

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
        return await database.DeleteDocsMutation({ Key: key })
      })

      res.json(data)
    } catch (error) {
      next(error)
    }
  }

  async uploadBinaryFiles(
    req: Request & { files: any[]; headers: { orderid: string } },
    res: Response,
    next: NextFunction
  ) {
    /**
     * Incoming request must contain a 'orderid'(integer) parameter in request headers.
     * The `Request` object will be populated with a `files` object containing
     * information about the processed file.
     *
     * hasuraUpload method adds file metadata into database using graphql server.
     */

    if (!req.headers.orderid) {
      throw ApiError.BadRequest(StaticStringKeys.MISSING_ORDERID_HEADER)
    }

    try {
      const array_of_files = req.files.map(each => ({
        Key: each.key,
        OrderID: parseInt(req.headers.orderid),
        FileName: each.originalname,
        Size: each.size
      }))

      const data = (await database.InsertDocsArrayMutation({ objects: array_of_files }))
        .insert_erp_Docs.returning

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
      const hasuraAdminSecret = req.query.hasura_admin_secret
      const key = req.params.key

      if (!hasuraAdminSecret) {
        throw ApiError.BadRequest('query-didnt-contain-hasura_admin_secret')
      }

      if (hasuraAdminSecret != config.HASURA_ADMIN_SECRET)
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
