import OrderService from '../repositories/order-stat.repository'
import { Request, Response, NextFunction } from 'express'

class OrderController {
  // Return array of unpaid orders ids.
  async getUnpaidOrders(req: Request, res: Response, next: NextFunction) {
    try {
      const data = await OrderService.getUnpaidOrders()

      return res.json(data)
    } catch (error) {
      next(error)
    }
  }
}

export default new OrderController()
