import { NextFunction, Request, Response } from 'express'
import ApiError from '../exceptions/api.error'

export default function (err: ApiError, req: Request, res: Response, next: NextFunction) {
  // next()
  // console.log('error middleware')
  if (err instanceof ApiError) {
    return res.status(err.status).json({
      error: {
        message: err.message,
        code: err.status
      }
    })
  }

  return res.send('some fuck')
}
