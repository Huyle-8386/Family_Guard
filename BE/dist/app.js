"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const dotenv_1 = __importDefault(require("dotenv"));
const auth_routes_1 = __importDefault(require("./modules/auth/auth.routes"));
const users_routes_1 = __importDefault(require("./modules/users/users.routes"));
const relationships_routes_1 = __importDefault(require("./modules/relationships/relationships.routes"));
const notifications_routes_1 = __importDefault(require("./modules/notifications/notifications.routes"));
dotenv_1.default.config();
const app = (0, express_1.default)();
app.use((0, cors_1.default)());
app.use(express_1.default.json());
app.get('/', (_req, res) => {
    res.json({ message: 'FamilyGuard Backend is running' });
});
app.use('/api', auth_routes_1.default);
app.use('/api', users_routes_1.default);
app.use('/api', relationships_routes_1.default);
app.use('/api', notifications_routes_1.default);
exports.default = app;
