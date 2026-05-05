"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PushTokensService = void 0;
const supabase_1 = require("../../config/supabase");
class PushTokensService {
    async upsertToken(params) {
        const token = params.token.trim();
        if (!token) {
            throw new Error('FCM token không hợp lệ');
        }
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_device_tokens')
            .upsert({
            uid: params.uid,
            token,
            platform: params.platform ?? null,
            device_id: params.deviceId ?? null,
            updated_at: new Date().toISOString(),
        }, { onConflict: 'token' })
            .select('id, uid, token, platform, device_id, updated_at')
            .single();
        if (error) {
            throw error;
        }
        return data;
    }
    async getTokensByUid(uid) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_device_tokens')
            .select('token')
            .eq('uid', uid);
        if (error) {
            throw error;
        }
        const tokens = (data ?? [])
            .map((item) => item.token?.toString().trim() ?? '')
            .filter((token) => token.length > 0);
        return [...new Set(tokens)];
    }
    async deleteTokens(tokens) {
        const validTokens = tokens
            .map((token) => token.trim())
            .filter((token) => token.length > 0);
        if (validTokens.length === 0) {
            return;
        }
        await supabase_1.supabaseAdmin.from('user_device_tokens').delete().in('token', validTokens);
    }
}
exports.PushTokensService = PushTokensService;
