"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const config_1 = require("./config/config");
const child_process_1 = require("child_process");
const app_1 = require("./app");
app_1.app.listen(config_1.config.PORT, () => {
    console.log('🛫 Express running in', config_1.config.NODE_ENV, 'mode.');
    if (config_1.config.NODE_ENV == 'development') {
        const local_IPv4 = (0, child_process_1.execSync)("ifconfig | grep  'inet '").toString();
        console.log(`Your local network settings: \n ${local_IPv4}`);
    }
});
