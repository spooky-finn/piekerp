module.exports = { apps : [{
  name      : 'backup-service',
  script    : 'postgres_backup_service.js',
  env       : {
    NODE_ENV: 'production',
    S3_ACCESS_KEY_ID: '_cj2xyDZCfVDtmbb7ULh',
    S3_SECRET_ACCESS_KEY: 'ivDdvFGWbXt3xDf7L17PN-5WMKyaOib1dSop66FL',
    S3_ENDPOINT: 's3.yandexcloud.net',
    S3_BUCKET: 'piek-factory-backup',
    MAX_BACKUPS: 100
  },
}]};