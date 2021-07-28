const express = require('express')
const Joi = require('joi')
const Boom = require('boom')
const uuidv4 = require('uuid/v4')




export const uploadFile = multer({
    storage: multerS3({
        s3: s3,
        bucket: S3_BUCKET,
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

            req.saved_files.push({
                originalname: file.originalname,
                mimetype: file.mimetype,
                endcoding: file.encoding,
                key,

            });

            cb(null, key);
        }
    })
})
var upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: S3_BUCKET,
        key: function (req, file, cb) {
            console.log(file);
            cb(null, file.originalname); //use Date.now() for unique file keys
        }
    })
});

exports.upload = upload
// const upload_auth = (req, res, next) => {
//     try {
//         req.s3_key_prefix = req.headers['x-path'].replace(/^\/+/g, '')
//     } catch (e) {
//         return next(Boom.badImplementation('x-path header incorrect'))
//     }

//     req.saved_files = [];
//     next();
// }

