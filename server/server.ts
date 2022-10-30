import * as dotenv from 'dotenv'
dotenv.config({ path: `../.env` })

import { execSync } from 'child_process'
import { app } from './app'

app.listen(process.env.PORT || '9000', () => {
  console.log('🛫 Express running in', process.env.NODE_ENV, 'mode.')

  if (process.env.NODE_ENV == 'development') {
    const local_IPv4 = execSync("ifconfig | grep  'inet '").toString()
    console.log(`Your local network settings: \n ${local_IPv4}`)
  }
})
