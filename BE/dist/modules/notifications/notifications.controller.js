"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.NotificationsController = void 0;
const notifications_service_1 = require("./notifications.service");
const notificationsService = new notifications_service_1.NotificationsService();
class NotificationsController {
    async listMine(req, res) {
        try {
            const data = await notificationsService.listMine(req.userId);
            return res.status(200).json({ data });
        }
        catch (error) {
            return res.status(500).json({
                message: 'Không lấy được notifications',
                error,
            });
        }
    }
    async respond(req, res) {
        try {
            const notificationId = Number(req.params.id);
            const action = req.body.action;
            if (Number.isNaN(notificationId)) {
                return res.status(400).json({
                    message: 'notificationId không hợp lệ',
                });
            }
            if (!['xacnhan', 'huy'].includes(action)) {
                return res.status(400).json({
                    message: 'action phải là xacnhan hoặc huy',
                });
            }
            const data = await notificationsService.respond(req.userId, notificationId, action);
            return res.status(200).json({
                message: 'Xử lý notification thành công',
                data,
            });
        }
        catch (error) {
            return res.status(400).json({
                message: error.message || 'Không xử lý được notification',
                error,
            });
        }
    }
}
exports.NotificationsController = NotificationsController;
