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
const config_1 = require("./config/config");
const child_process_1 = require("child_process");
const app_1 = require("./app");
app_1.app.listen(config_1.config.PORT, () => __awaiter(void 0, void 0, void 0, function* () {
    console.log('🛫 Express running in', config_1.config.NODE_ENV, 'mode.');
    if (config_1.config.NODE_ENV == 'development') {
        const local_IPv4 = (0, child_process_1.execSync)("ifconfig | grep  'inet '").toString();
        console.log(`Your local network settings: \n ${local_IPv4}`);
    }
}));
//# sourceMappingURL=server.js.map