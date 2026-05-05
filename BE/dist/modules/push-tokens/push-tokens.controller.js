"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PushTokensController = void 0;
const push_tokens_service_1 = require("./push-tokens.service");
const pushTokensService = new push_tokens_service_1.PushTokensService();
class PushTokensController {
    async registerToken(req, res) {
        try {
            const token = String(req.body?.token ?? '').trim();
            const platform = req.body?.platform
                ? String(req.body.platform).trim()
                : null;
            const deviceId = req.body?.device_id
                ? String(req.body.device_id).trim()
                : null;
            if (!token) {
                return res.status(400).json({ message: 'Thiếu FCM token' });
            }
            const data = await pushTokensService.upsertToken({
                uid: req.userId,
                token,
                platform,
                deviceId,
            });
            return res.status(200).json({
                message: 'Đăng ký FCM token thành công',
                data,
            });
        }
        catch (error) {
            return res.status(500).json({
                message: error.message || 'Không đăng ký được FCM token',
                error,
            });
        }
    }
}
exports.PushTokensController = PushTokensController;
