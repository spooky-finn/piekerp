import StatusCodes from 'http-status-codes'

export default class ApiError extends Error {
  constructor(
    public status: number,
    message: string,

    public details?: string,
    public stack?: string
  ) {
    super(message)
  }

  static UnauthorizedError(message: string) {
    return new ApiError(StatusCodes.UNAUTHORIZED, message)
  }

  static BadRequest(message: string) {
    return new ApiError(StatusCodes.BAD_REQUEST, message)
  }

  static HasuraServiceError(message: string, details: string, stack?: string) {
    return new ApiError(StatusCodes.INTERNAL_SERVER_ERROR, message, details, stack)
  }
}
