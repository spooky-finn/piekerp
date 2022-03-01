const dotenv = require('dotenv');
dotenv.config({ path: `../.env` });

module.exports = { apps : [{
  name      : 'backup_service',
  script    : 'index.js',
  env       : {
    NODE_ENV: process.env.NODE_ENV,
    S3_ACCESS_KEY_ID: process.env.S3_BACKUP_SERVICE_ACCESS_KEY_ID,
    S3_SECRET_ACCESS_KEY: process.env.S3_BACKUP_SERVICE_SECRET_ACCESS_KEY,
    S3_ENDPOINT: process.env.S3_ENDPOINT,
    S3_BUCKET: process.env.S3_BACKUP_SERVICE_BUCKET,
    MAX_BACKUPS: process.env.S3_BACKUP_SERVICE_MAX_BACKUPS,
    RETRY_TIMEOUT: process.env.S3_BACKUP_SERVICE_RETRY_TIMEOUT
  },
}]};
