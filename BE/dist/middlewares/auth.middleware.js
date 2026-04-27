"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.authMiddleware = authMiddleware;
const supabase_1 = require("../config/supabase");
async function authMiddleware(req, res, next) {
    try {
        const authHeader = req.headers.authorization;
        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return res.status(401).json({ message: 'Thiếu access token' });
        }
        const token = authHeader.replace('Bearer ', '').trim();
        const { data: { user }, error, } = await supabase_1.supabaseAdmin.auth.getUser(token);
        if (error || !user) {
            return res.status(401).json({ message: 'Token không hợp lệ' });
        }
        req.userId = user.id;
        req.accessToken = token;
        next();
    }
    catch (error) {
        return res.status(500).json({ message: 'Lỗi xác thực', error });
    }
}
