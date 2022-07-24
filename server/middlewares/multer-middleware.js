var multer = require('multer');
var multerS3 = require('multer-s3');
const uuidv4 = require('uuid/v4');
const querystring = require('querystring');

const awsClient = require('../lib/s3-client')

const multerMiddleware = multer({
    storage: multerS3({
        s3: awsClient,
        bucket: process.env.S3_BUCKET,
        storageClass: 'COLD',
        contentType: multerS3.AUTO_CONTENT_TYPE,
        metadata: (req, file, cb) => {
            cb(null, {
                originalname: querystring.escape(file.originalname),
            });
        },
        key: function (req, file, cb){
            //generate unique file names to be saved on the server 
            cb(null, uuidv4());
        }
    })
}).array('files', 20);

module.exports = multerMiddleware