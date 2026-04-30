"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersController = void 0;
const users_service_1 = require("./users.service");
const users_validation_1 = require("./users.validation");
const usersService = new users_service_1.UsersService();
class UsersController {
    async getMe(req, res) {
        try {
            const data = await usersService.getMe(req.userId);
            return res.json({ data });
        }
        catch (error) {
            return res.status(500).json({ message: 'Không lấy được thông tin user', error });
        }
    }
    async updateMe(req, res) {
        try {
            const parsed = users_validation_1.updateMeSchema.safeParse(req.body);
            if (!parsed.success) {
                return res.status(400).json({ message: 'Dữ liệu không hợp lệ', errors: parsed.error.flatten() });
            }
            const data = await usersService.updateMe(req.userId, parsed.data);
            return res.json({ message: 'Cập nhật thành công', data });
        }
        catch (error) {
            return res.status(500).json({ message: 'Không cập nhật được user', error });
        }
    }
    async searchUsers(req, res) {
        try {
            const q = String(req.query.q ?? '').trim();
            if (!q) {
                return res.status(400).json({ message: 'Thiếu từ khóa tìm kiếm' });
            }
            const data = await usersService.searchUsers(req.userId, q);
            return res.json({ data });
        }
        catch (error) {
            return res.status(500).json({ message: 'Không tìm được user', error });
        }
    }
}
exports.UsersController = UsersController;
