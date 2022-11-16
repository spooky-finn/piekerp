import cookieParser from 'cookie-parser'
import cors from 'cors'
import express, { json, static as ExpressStatic, urlencoded } from 'express'
import path from 'path'
import { config } from './config/config'
import errorMiddleware from './middlewares/error.middleware'
import { router as indexRouter } from './routes'

const CLIENT_BUILD_PATH =
  config.NODE_ENV === 'production' ? '/app/client/build' : '../../../client/build'
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

app.use('/api', indexRouter)

app.use(errorMiddleware)

// All remaining requests return the React app, so it can handle routing.
app.get('*', function (request, response) {
  console.log('path to', path.join(__dirname, CLIENT_BUILD_PATH))
  response.sendFile(path.join(__dirname, CLIENT_BUILD_PATH, 'index.html'))
})
