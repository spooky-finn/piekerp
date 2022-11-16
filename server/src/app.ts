import cookieParser from 'cookie-parser'
import cors from 'cors'
import express from 'express'
import path from 'path'
import { config } from './config/config'
import errorMiddleware from './middlewares/error.middleware'
import { router as indexRouter } from './routes'

const clientBuild = path.join(__dirname, '../../client/build')

export const app = express()

// Static files
app.use(express.static(clientBuild))

app.use(express.urlencoded({ extended: false }))

//Middlewares
app.use(express.json())

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
  console.log(clientBuild)
  response.sendFile('index.html', { root: clientBuild })
})
