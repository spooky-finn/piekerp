import { app } from './app'
import { config } from './config/config'

app.listen(config.PORT, async () => {
  console.log('🛫 Express running in', config.NODE_ENV, 'mode.')
})
