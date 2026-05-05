"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_middleware_1 = require("../../middlewares/auth.middleware");
const push_tokens_controller_1 = require("./push-tokens.controller");
const router = (0, express_1.Router)();
const controller = new push_tokens_controller_1.PushTokensController();
router.post('/devices/fcm-token', auth_middleware_1.authMiddleware, controller.registerToken.bind(controller));
exports.default = router;
