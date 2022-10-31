import StatusCodes from 'http-status-codes'

export default class ApiError extends Error {
  status: number

  constructor(status: number, message: string) {
    super(message)
    this.status = status
  }

  static UnauthorizedError(message: string) {
    return new ApiError(StatusCodes.UNAUTHORIZED, message)
  }

  static BadRequest(message: string) {
    return new ApiError(StatusCodes.BAD_REQUEST, message)
  }

  static HasuraServiceError(message: string) {
    return new ApiError(StatusCodes.INTERNAL_SERVER_ERROR, message)
  }
}
