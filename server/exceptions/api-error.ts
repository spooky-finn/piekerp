export default class ApiError extends Error {
  status

  constructor(status: Number, message: string) {
    super(message)
    this.status = status
    // this.detail = detail
  }

  static UnauthorizedError(message: string) {
    return new ApiError(401, message)
  }

  static BadRequest(message: string) {
    return new ApiError(400, message)
  }

  static HasuraServiceError(message: string) {
    return new ApiError(500, message)
  }
}
