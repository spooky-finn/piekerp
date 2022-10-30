"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const HasuraClient_1 = __importDefault(require("../lib/HasuraClient"));
const graphql_request_1 = require("graphql-request");
const GET_ALL_ORDERS = (0, graphql_request_1.gql) `
    query{
    erp_Orders(
        where: {OrderStatusID: {_eq: 3}},
        order_by: {OrderID: desc},
        ){
        OrderID
        PaidAmount
        TotalAmount
    }
    }
`;
const GET_UNPAID_ORDERS = (0, graphql_request_1.gql) `
    query MyQuery($unpaidIDs: [Int!], $OrderStatus: Int!) {
        erp_Orders(where: { OrderStatusID: {_eq: $OrderStatus}, OrderID: {_in: $unpaidIDs } } ) {
        OrderID
        Entity
        InvoiceNumber
        City
        OrderStatusID
        ShippingDate
        PaidAmount
        TotalAmount
        AwaitingDispatch
        ActualShippingDate
        CreatingDate
        ManagerID
        OrderItems {
            Quantity
            OrderItemID
            Name
        } 
        User {
            FirstName
        }
        }
    }
`;
class HasuraOrderService extends HasuraClient_1.default {
    getUnpaidOrdersIDs() {
        return __awaiter(this, void 0, void 0, function* () {
            const res = yield this._send(GET_ALL_ORDERS);
            const unpaidOrders = res.data.erp_Orders
                .filter(e => e.PaidAmount / e.TotalAmount < .999)
                .map(e => e.OrderID);
            return unpaidOrders;
        });
    }
    getUnpaidOrders() {
        return __awaiter(this, void 0, void 0, function* () {
            const unpaidOrdersIDs = this.getUnpaidOrdersIDs();
            const variables = { unpaidIDs: unpaidOrdersIDs, OrderStatus: 3 };
            const res = yield this._send(GET_UNPAID_ORDERS, variables);
            return res.data.erp_Orders;
        });
    }
}
exports.default = new HasuraOrderService();
