import ApiError from '../exceptions/api-error'

export default function (err: any, req, res, next) {
  console.log(err, req)

  if (err instanceof ApiError) {
    return res.status(err.status).json({
      error: {
        message: err.message,
        code: err.status
        // detail: err.detail
      }
    })
  }
  return res.status(500).json({
    error: {
      message: err.message,
      code: err.status
    }
  })
}
