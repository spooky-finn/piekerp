const hasuraOrderService = require('../service/hasura-order-service')


class OrderController {

    // Return array of unpaid orders ids.
    async getUnpaidOrders(req, res, next) {
        try {
            const data = await hasuraOrderService.getUnpaidOrdersIDs();
            return res.json(data)
        } catch (error) {
            next(error)
        }
    }
}

module.exports = new OrderController();