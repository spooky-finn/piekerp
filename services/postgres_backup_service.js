require('dotenv').config(); 
const fs = require('fs');
const { exec } = require('child_process');
const AWS = require('aws-sdk');

const s3 = new AWS.S3({
  accessKeyId: process.env.S3_ACCESS_KEY_ID,
  secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
  endpoint: process.env.S3_ENDPOINT,
  s3ForcePathStyle: true,
  signatureVersion: 'v4',
});

const fileName = '.env';

const uploadFile = () => {

  fs.readFile(fileName, (err, data) => {
     if (err) throw err;
     const params = {
         Bucket: 'piek-factory-backup', // pass your bucket name
         Key: 'postgres-backup',
         Body: JSON.stringify(data, null, 2)
     };
     s3.upload(params, function(s3Err, data) {
         if (s3Err) throw s3Err
         console.log(`File uploaded successfully at ${data.Location}`)
     });
  });
};

function intervalFunc() {
  const exexCont = "sudo docker exec hasura_postgres_1 ls"
  exec(exexCont, (err, stdout) => {
    if (err) console.log(err)
    else{
      uploadFile()
      console.log(stdout)
    }
  })
}

setInterval(intervalFunc, 3000);
