const awsClient = require('../lib/s3-client')
const querystring = require('querystring');


class S3Service {

    async deleteObject(key, bucket) {
        const params = { Bucket: bucket, Key: key };

        return awsClient.deleteObject(params, function (err, data) {
            if (err) throw new Error(`Could not delete file from S3: ${err.message}`)
            return data;
        })
    }

    async getObject(key) {
        const params = { Bucket: process.env.S3_BUCKET, Key: key };

        try {
            const data = await awsClient.getObject(params).promise();
            data.Metadata.originalname = querystring.unescape(data.Metadata.originalname);
            return data;
        } catch (e) {
            throw new Error(`Could not retrieve file from S3: ${e.message}`);
        }

    }

}

module.exports = new S3Service();