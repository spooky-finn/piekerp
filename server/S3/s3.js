var multer = require('multer');
var multerS3 = require('multer-s3');
const AWS = require('aws-sdk');
const uuidv4 = require('uuid/v4');


const s3 = new AWS.S3({
    accessKeyId: process.env.S3_ACCESS_KEY_ID,
    secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
    endpoint: process.env.S3_ENDPOINT,
    s3ForcePathStyle: true,
    signatureVersion: 'v4',
  });
  
  const upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: process.env.S3_BUCKET,
        metadata: (req, file, cb) => {
            cb(null, {
                originalname: file.originalname,
            });
        },
        contentType: function(req, file, cb){
            cb(null, file.mimetype);
        },
        key: function (req, file, cb){
            
            //generate unique file names to be saved on the server 
            const uuid = uuidv4();
            const key = `${req.s3_key_prefix}${uuid}`;

            req.files.push({
                originalname: file.originalname,
                mimetype: file.mimetype,
                key,

            });

            cb(null, key);
        }
    })
})

module.exports = upload