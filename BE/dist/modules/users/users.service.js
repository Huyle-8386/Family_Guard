"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersService = void 0;
const supabase_1 = require("../../config/supabase");
class UsersService {
    async getMe(uid) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_info')
            .select('uid, name, email, phone, birthday, sex, address, role, avata, created_at')
            .eq('uid', uid)
            .single();
        if (error)
            throw error;
        return data;
    }
    async updateMe(uid, payload) {
        const { email, ...profileData } = payload;
        if (email) {
            const { error: authError } = await supabase_1.supabaseAdmin.auth.admin.updateUserById(uid, {
                email,
            });
            if (authError)
                throw authError;
        }
        const updateData = { ...profileData };
        if (email)
            updateData.email = email;
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_info')
            .update(updateData)
            .eq('uid', uid)
            .select('uid, name, email, phone, birthday, sex, address, role, avata, created_at')
            .single();
        if (error)
            throw error;
        return data;
    }
    async searchUsers(currentUid, q) {
        const keyword = q.trim();
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_info')
            .select('uid, name, email, phone, role, avata')
            .neq('uid', currentUid)
            .or(`email.ilike.%${keyword}%,phone.ilike.%${keyword}%`)
            .limit(20);
        if (error)
            throw error;
        const { data: relationships } = await supabase_1.supabaseAdmin
            .from('relationship')
            .select('uid, relation_id, processing')
            .or(`uid.eq.${currentUid},relation_id.eq.${currentUid}`)
            .not('processing', 'in', '(daxoa,huy)');
        const blockedIds = new Set();
        for (const item of relationships ?? []) {
            if (item.uid === currentUid)
                blockedIds.add(item.relation_id);
            if (item.relation_id === currentUid)
                blockedIds.add(item.uid);
        }
        return (data ?? []).filter((item) => !blockedIds.has(item.uid));
    }
}
exports.UsersService = UsersService;
