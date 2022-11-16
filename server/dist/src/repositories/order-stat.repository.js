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
Object.defineProperty(exports, "__esModule", { value: true });
const graphql_client_1 = require("../lib/graphql-client");
class OrderStatRepository {
    getUnpaidOrders() {
        return __awaiter(this, void 0, void 0, function* () {
            const unpaidOrdersIDs = (yield graphql_client_1.database.AllOrdersPaymentsDataQuery()).erp_Orders
                .filter(e => e.PaidAmount / e.TotalAmount < 0.999)
                .map(e => e.OrderID);
            return unpaidOrdersIDs;
        });
    }
}
exports.default = new OrderStatRepository();
//# sourceMappingURL=order-stat.repository.js.map