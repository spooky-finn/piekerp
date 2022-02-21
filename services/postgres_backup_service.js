
// Pull out the postgress backup from docker container and send it to S3.

// Script must run using pm.comfig.js in order to connect process enviropment
// pm.comfig.js  looks something like that

// module.exports = { apps : [{
//     name      : 'backup-service',
//     script    : 'postgres_backup_service.js',
//     env       : {
//       NODE_ENV: 'production',
//       S3_ACCESS_KEY_ID: '',
//       S3_SECRET_ACCESS_KEY: '',
//       S3_ENDPOINT: 's3.yandexcloud.net',
//       S3_BUCKET: ''
//       MAX_BACKUPS: 100,
//       RETRY_TIMEOUT: 36000
//     },
//   }]};
  

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


function main() {
  // Удаление старых бэкапов при достижении предельного количества
    s3.listObjects( {Bucket: process.env.S3_BUCKET}, function(err, data){
        if (err) throw err;
        // console.log(data);
        if (data.Contents.length > process.env.MAX_BACKUPS){
            data.Contents.sort(function(a,b){
                // Turn your strings into dates, and then subtract them
                // to get a value that is either negative, positive, or zero.
                return new Date(a.LastModified) - new Date(b.LastModified);
            });
            
            const params = { Bucket: process.env.S3_BUCKET, Key: data.Contents[0].Key };

            s3.deleteObject(params, function(err, data){
                if (err) console.log(err, err.stack)
                else     console.log('object was deleted', data);   
            })
        }
    })
  
     // terminal command to get database dump from docker container
    const execCont = "docker exec hasura_postgres_1 pg_dump -U postgres -d postgres > dump.sql"

    exec(execCont, (err, stdout, stderr) => {
        if (err || stderr) console.log(err, stderr)
        else{
            console.log('pg dump created.');
            
            // Выгружаем дамп в объектное хранилище
            fs.readFile('dump.sql', { encoding: 'utf-8' }, (err, data) => {
                if (err) throw err;

                const params = {
                    Bucket: process.env.S3_BUCKET,
                    Key: 'pg-backup ' + new Date().toISOString(),
                    ContentType: "text/plain;charset=utf-8",
                    Body: JSON.stringify(data, null, 2)
                };

                s3.upload(params, function(s3Err, data) {
                    if (s3Err) throw s3Err
                    console.log(`File uploaded successfully at ${data.Location}`)
                });
            });
            
            console.log(stdout)
        }
    })
}

setInterval(main, process.env.RETRY_TIMEOUT)

