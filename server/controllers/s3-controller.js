const ApiError = require('../exceptions/api-error');
const HasuraS3Service = require('../service/hasura-s3-service');
const S3Service = require('../service/s3-service')
const S3Clients = require('../lib/S3Clients')


class S3Controller {
    async removeSingleFile(req, res, next) {
        /**
        * Incoming request must contain a 'orderid'(integer) parameter in request headers. 
        * The `Request` object will be populated with a `files` object containing
        * information about the processed file.
        * 
        * hasuraUpload method adds file metadata into database using graphql server.
        */
        try {
            const key = req.params.key;
            const data = await S3Service.deleteObject(key, process.env.S3_BUCKET).then(async s3_responce => {
                return await HasuraS3Service.removeFileInformation(key)
            })

            res.json(data)
        } catch (error) {
            next(error)
        }
    }

    async uploadBinaryFiles(req, res, next) {
        /**
        * Incoming request must contain a 'orderid'(integer) parameter in request headers. 
        * The `Request` object will be populated with a `files` object containing
        * information about the processed file.
        * 
        * hasuraUpload method adds file metadata into database using graphql server.
        */
        try {
            const array_of_files = req.files.map(each => ({
                'Key': each.key,
                'OrderID': (req.headers.orderid),
                'FileName': each.originalname,
                'Size': each.size
            }));

            const data = await HasuraS3Service.addFileInformation(array_of_files)
            res.send(data)
        } catch (error) {
            next(error)
        }


    }

    async getBinaryFile(req, res, next) {
        try {
            const data = await S3Service.getObject(req.params.key, process.env.S3_BUCKET)
            const fileName = encodeURI(data.Metadata.originalname)
            res.set('Content-Type', data.ContentType);
            res.set('Content-Disposition', `inline;filename*=utf-8''${fileName}`)
            res.send(data.Body);
        } catch (error) {
            next(error)
        }
    }

    async getHasuraBackup(req, res, next) {
        try {
            const hasuraAdminSectret = req.query.hasura_admin_secret
            const key = req.params.key

            if (!hasuraAdminSectret)
                throw ApiError.BadRequest('query-didnt-contain-hasura_admin_secret')

            if (hasuraAdminSectret != process.env.HASURA_ADMIN_SECRET)
                throw ApiError.BadRequest('wrong-hasura_admin_secret-in-query')

            const params = { Bucket: process.env.S3_BACKUP_SERVICE_BUCKET, Key: key };
            const data = await S3Clients.backupS3Client.getObject(params).promise()

            res.set('Content-Type', 'text/plain');
            res.set('Content-Disposition', `attachment; filename="db_dump.sql"`)

            return res.send(JSON.parse(data.Body));
        } catch (error) {
            next(error)
        }
    }
}

module.exports = new S3Controller();