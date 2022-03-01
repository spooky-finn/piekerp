const AWS = require('aws-sdk');

const awsClient = new AWS.S3({
    accessKeyId: process.env.S3_ACCESS_KEY_ID,
    secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
    endpoint: process.env.S3_ENDPOINT,
    s3ForcePathStyle: true,
    signatureVersion: 'v4',
  });

module.exports = awsClient;


// const download = (key, res) => {

//   const getParams = {
//     Bucket: process.env.S3_BUCKET,
//     Key: key
//   };
//   s3.getObject(getParams, function(err, data) {
//     if (err) return res.status(400).send({success:false,err:err})
    
//     else{
//         data.Metadata.originalname = querystring.unescape(data.Metadata.originalname)
//         const fileName = encodeURI(data.Metadata.originalname)
//         res.set('Content-Type', data.ContentType); 
//         res.set('Content-Disposition', `inline;filename*=utf-8''${fileName}`)
//       return res.send(data.Body);
//     }
//   });
// }

// const getBackup = (key, res) => {
//   const getParams = {
//     Bucket: 'piek-factory-backup',
//     Key: key
//   };
//   s3.getObject(getParams, function(err, data) {
//     if (err) return res.status(400).send({success:false,err:err})
    
//     else{
//         data.Metadata.originalname = querystring.unescape(data.Metadata.originalname)
//         const fileName = encodeURI(data.Metadata.originalname)
//         res.set('Content-Type', 'text/plain'); 
//         res.set('Content-Disposition', `attachment; filename="db_dump.sql"`)

//       return res.send(JSON.parse(data.Body));
//     }
//   });
// }
  
// // const upload = multer({
// //     storage: multerS3({
// //         s3: s3,
// //         bucket: process.env.S3_BUCKET,
// //         storageClass: 'COLD',
// //         contentType: multerS3.AUTO_CONTENT_TYPE,
// //         metadata: (req, file, cb) => {
// //             cb(null, {
// //                 originalname: querystring.escape(file.originalname),
// //             });
// //         },
// //         key: function (req, file, cb){
// //             //generate unique file names to be saved on the server 
// //             cb(null, uuidv4());
// //         }
// //     })
// // })

// const deleteObject = (key) => {
//   const params = { Bucket: process.env.S3_BUCKET, Key: key };
  
//   s3.deleteObject(params, function(err, data){
//     if (err) console.log(err, err.stack)
//     else     console.log(data);   

//   })
// }

// exports.deleteObject = deleteObject;
// // exports.upload = upload;
// exports.download = download;
// exports.getBackup = getBackup;