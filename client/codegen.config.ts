import { CodegenConfig } from '@graphql-codegen/cli'
import * as dotenv from 'dotenv'
dotenv.config({ path: `../.env` })

if (!process.env.HASURA_ENDPOINT || !process.env.HASURA_ADMIN_SECRET) {
  throw Error('Hasura connection params must be provided (☆^ー^☆)')
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
  documents: ['./**/*.gql'],
  generates: {
    './src/types/graphql-shema.ts': {
      plugins: ['typescript', 'typescript-operations', 'typescript-react-apollo']
    }
  }
}

export default config
