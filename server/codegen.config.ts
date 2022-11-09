import * as dotenv from 'dotenv'
dotenv.config({ path: '../.env' })
import { CodegenConfig } from '@graphql-codegen/cli'

if (!process.env.HASURA_ENDPOINT || !process.env.HASURA_ADMIN_SECRET) {
  throw Error('Null Hasura params')
}

const config: CodegenConfig = {
  schema: [
    {
      [process.env.HASURA_ENDPOINT]: {
        headers: {
          'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET
        }
      }
    }
  ],
  documents: ['./src/**/*.gql'],
  generates: {
    './generated/schema-typedefs.ts': {
      plugins: ['typescript', 'typescript-operations', 'typescript-generic-sdk']
    }
  }
}

export default config
