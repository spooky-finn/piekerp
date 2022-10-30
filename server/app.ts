import * as dotenv from 'dotenv'
dotenv.config({ path: `../.env` })
import express, { static as ExpressStatic, urlencoded, json } from 'express'
import { join } from 'path'
import cookieParser from 'cookie-parser'
import logger from 'morgan'
import cors from 'cors'

import errorMiddleware from './middlewares/error-middleware'

//prod
const CLIENT_BUILD_PATH = '../client/build'

import { router as indexRouter } from './routes/index'

export const app = express()

// Static files
app.use(ExpressStatic(CLIENT_BUILD_PATH))

app.use(logger('dev'))

app.use(urlencoded({ extended: false }))

//Middlewares
app.use(json())

app.use(cookieParser())

app.use(
  cors({
    credentials: true,
    origin: process.env.CORS_CLIENT_URL
  })
)

app.use(errorMiddleware)
app.use('/api', indexRouter)

// All remaining requests return the React app, so it can handle routing.
app.get('*', function (request, response) {
  response.sendFile(join(CLIENT_BUILD_PATH, 'index.html'))
})
