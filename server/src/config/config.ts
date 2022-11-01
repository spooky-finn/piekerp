import path from 'path'
import dotenv from 'dotenv'

// Parsing the env file.
dotenv.config({ path: path.resolve(process.cwd(), '../.env') })

interface Config {
  PORT: number
  NODE_ENV: string
  HASURA_ENDPOINT: string
  S3_ENDPOINT: string
  S3_BUCKET: string

  JWT_ACCESS_SECRET: string
  JWT_REFRESH_SECRET: string
  JWT_ACCESS_SECRET_EXPIRES: string
  JWT_REFRESH_SECRET_EXPIRES: string

  CORS_CLIENT_URL: string

  HASURA_ADMIN_SECRET: string

  S3_ACCESS_KEY_ID: string
  S3_SECRET_ACCESS_KEY: string

  // backups
  S3_BACKUP_SERVICE_BUCKET: string
  S3_BACKUP_SERVICE_ACCESS_KEY_ID: string
  S3_BACKUP_SERVICE_SECRET_ACCESS_KEY: string
}

// Throwing an Error if any field was undefined we don't
// want our app to run if it can't connect to DB and ensure
// that these fields are accessible. If all is good return
// it as Config which just removes the undefined from our type
// definition.

const getSanitzedConfig = (config: Config): Config => {
  for (const [key, value] of Object.entries(config)) {
    if (!value) {
      throw new Error(`Missing key ${key} in .env`)
    }
  }
  return config as Config
}

export const config = getSanitzedConfig({
  NODE_ENV: process.env.NODE_ENV,

  PORT: process.env.Port ? Number(process.env.PORT) : 9000,
  CORS_CLIENT_URL: process.env.CORS_CLIENT_URL,

  HASURA_ADMIN_SECRET: process.env.HASURA_ADMIN_SECRET,
  HASURA_ENDPOINT: process.env.HASURA_ENDPOINT,

  JWT_ACCESS_SECRET: process.env.JWT_ACCESS_SECRET,
  JWT_REFRESH_SECRET: process.env.JWT_REFRESH_SECRET,
  JWT_ACCESS_SECRET_EXPIRES: process.env.JWT_ACCESS_SECRET_EXPIRES ?? '30m',
  JWT_REFRESH_SECRET_EXPIRES: process.env.JWT_REFRESH_SECRET_EXPIRES ?? '30d',

  S3_ACCESS_KEY_ID: process.env.S3_ACCESS_KEY_ID,
  S3_SECRET_ACCESS_KEY: process.env.S3_SECRET_ACCESS_KEY,
  S3_BUCKET: process.env.S3_BUCKET ?? 'factory-piek-test',
  S3_ENDPOINT: process.env.S3_ENDPOINT ?? 's3.yandexcloud.net',

  S3_BACKUP_SERVICE_BUCKET: process.env.S3_BACKUP_SERVICE_BUCKET,
  S3_BACKUP_SERVICE_ACCESS_KEY_ID: process.env.S3_BACKUP_SERVICE_ACCESS_KEY_ID,
  S3_BACKUP_SERVICE_SECRET_ACCESS_KEY: process.env.S3_BACKUP_SERVICE_SECRET_ACCESS_KEY
})
