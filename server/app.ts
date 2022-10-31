import cookieParser from 'cookie-parser'
import cors from 'cors'
import express, { json, static as ExpressStatic, urlencoded } from 'express'
import { join } from 'path'
import { config } from './config/config'
import errorMiddleware from './middlewares/error-middleware'
import { router as indexRouter } from './routes/index'

const CLIENT_BUILD_PATH = '../client/build'

export const app = express()

// Static files
app.use(ExpressStatic(CLIENT_BUILD_PATH))

app.use(urlencoded({ extended: false }))

//Middlewares
app.use(json())

app.use(cookieParser())

app.use(
  cors({
    credentials: true,
    origin: config.CORS_CLIENT_URL
  })
)

app.use(errorMiddleware)
app.use('/api', indexRouter)

// All remaining requests return the React app, so it can handle routing.
app.get('*', function (request, response) {
  response.sendFile(join(CLIENT_BUILD_PATH, 'index.html'))
})
