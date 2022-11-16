"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
var _a, _b, _c, _d;
Object.defineProperty(exports, "__esModule", { value: true });
exports.config = void 0;
const path_1 = __importDefault(require("path"));
const dotenv_1 = __importDefault(require("dotenv"));
// Parsing the env file.
dotenv_1.default.config({ path: path_1.default.resolve(process.cwd(), '../.env') });
// Throwing an Error if any field was undefined we don't
// want our app to run if it can't connect to DB and ensure
// that these fields are accessible. If all is good return
// it as Config which just removes the undefined from our type
// definition.
const getSanitzedConfig = (config) => {
    for (const [key, value] of Object.entries(config)) {
        if (!value) {
            throw new Error(`Missing key ${key} in .env`);
        }
    }
    return config;
};
exports.config = getSanitzedConfig({
    NODE_ENV: process.env.NODE_ENV,
    PORT: process.env.Port ? Number(process.env.PORT) : 9000,
    CORS_CLIENT_URL: process.env.CORS_CLIENT_URL,
    HASURA_ADMIN_SECRET: process.env.HASURA_ADMIN_SECRET,
    HASURA_ENDPOINT: process.env.HASURA_ENDPOINT,
    JWT_ACCESS_SECRET: process.env.JWT_ACCESS_SECRET,
    JWT_REFRESH_SECRET: process.env.JWT_REFRESH_SECRET,
    JWT_ACCESS_SECRET_EXPIRES: (_a = process.env.JWT_ACCESS_SECRET_EXPIRES) !== null && _a !== void 0 ? _a : '30m',
    JWT_REFRESH_SECRET_EXPIRES: (_b = process.env.JWT_REFRESH_SECRET_EXPIRES) !== null && _b !== void 0 ? _b : '30d',
    S3_ACCESS_KEY_ID: process.env.S3_ACCESS_KEY_ID,
    S3_SECRET_ACCESS_KEY: process.env.S3_SECRET_ACCESS_KEY,
    S3_BUCKET: (_c = process.env.S3_BUCKET) !== null && _c !== void 0 ? _c : 'factory-piek-test',
    S3_ENDPOINT: (_d = process.env.S3_ENDPOINT) !== null && _d !== void 0 ? _d : 's3.yandexcloud.net',
    S3_BACKUP_SERVICE_BUCKET: process.env.S3_BACKUP_SERVICE_BUCKET,
    S3_BACKUP_SERVICE_ACCESS_KEY_ID: process.env.S3_BACKUP_SERVICE_ACCESS_KEY_ID,
    S3_BACKUP_SERVICE_SECRET_ACCESS_KEY: process.env.S3_BACKUP_SERVICE_SECRET_ACCESS_KEY
});
//# sourceMappingURL=config.js.map