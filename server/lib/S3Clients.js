const AWS = require('aws-sdk');

class S3Clients {
    constructor() {
        this.mainS3Client = new AWS.S3({
            accessKeyId: process.env.S3_ACCESS_KEY_ID,
            secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
            endpoint: process.env.S3_ENDPOINT,
            s3ForcePathStyle: true,
            signatureVersion: 'v4',
        })

        this.backupS3Client = new AWS.S3({
            accessKeyId: process.env.S3_BACKUP_SERVICE_ACCESS_KEY_ID,
            secretAccessKey: process.env.S3_BACKUP_SERVICE_SECRET_ACCESS_KEY,
            endpoint: process.env.S3_ENDPOINT,
            s3ForcePathStyle: true,
            signatureVersion: 'v4',
        })
    }
}



module.exports = new S3Clients()