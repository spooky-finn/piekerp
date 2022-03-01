const awsClient = require('../S3/s3-client')
const querystring = require('querystring');


class S3Service {

    async deleteObjecttt(key){
        const params = { Bucket: process.env.S3_BUCKET, Key: key };
        
        return awsClient.deleteObject(params, function(err, data){
            if (err) return err;
            return data;
        })
    }

    getObject(key){
        const params = { Bucket: process.env.S3_BUCKET, Key: key };

        return awsClient.getObject(params).promise()
        .then( data => {
            data.Metadata.originalname = querystring.unescape(data.Metadata.originalname);
            return data
        })
        .catch( e => {
            throw new Error(`Could not retrieve file from S3: ${e.message}`)
        })

    }
}

module.exports = new S3Service();