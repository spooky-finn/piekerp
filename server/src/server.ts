import { config } from './config/config'

import { execSync } from 'child_process'
import { app } from './app'

app.listen(config.PORT, async () => {
  console.log('🛫 Express running in', config.NODE_ENV, 'mode.')

  if (config.NODE_ENV == 'development') {
    const local_IPv4 = execSync("ifconfig | grep  'inet '").toString()
    console.log(`Your local network settings: \n ${local_IPv4}`)
  }
})
