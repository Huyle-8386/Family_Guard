"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const auth_service_1 = require("./auth.service");
const auth_validation_1 = require("./auth.validation");
const authService = new auth_service_1.AuthService();
class AuthController {
    async login(req, res) {
        try {
            const parsed = auth_validation_1.loginSchema.safeParse(req.body);
            if (!parsed.success) {
                return res.status(400).json({
                    message: 'Dữ liệu không hợp lệ',
                    errors: parsed.error.flatten(),
                });
            }
            const data = await authService.login(parsed.data.email, parsed.data.password);
            return res.status(200).json({
                message: 'Đăng nhập thành công',
                data,
            });
        }
        catch (error) {
            return res.status(400).json({
                message: error?.message || 'Đăng nhập thất bại',
            });
        }
    }
    async logout(req, res) {
        try {
            const authHeader = req.headers.authorization;
            if (!authHeader || !authHeader.startsWith('Bearer ')) {
                return res.status(401).json({
                    message: 'Thiếu access token',
                });
            }
            const accessToken = authHeader.replace('Bearer ', '').trim();
            const data = await authService.logout(accessToken);
            return res.status(200).json({
                message: 'Đăng xuất thành công',
                data,
            });
        }
        catch (error) {
            return res.status(400).json({
                message: error?.message || 'Đăng xuất thất bại',
            });
        }
    }
    async me(req, res) {
        try {
            if (!req.userId) {
                return res.status(401).json({
                    message: 'Người dùng chưa được xác thực',
                });
            }
            const data = await authService.me(req.userId);
            return res.status(200).json({
                message: 'Lấy thông tin thành công',
                data,
            });
        }
        catch (error) {
            return res.status(500).json({
                message: error?.message || 'Không lấy được thông tin người dùng',
            });
        }
    }
}
exports.AuthController = AuthController;
