"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const supabase_1 = require("../../config/supabase");
function calculateAge(birthday) {
    if (!birthday)
        return null;
    const birthDate = new Date(birthday);
    if (Number.isNaN(birthDate.getTime()))
        return null;
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    if (monthDiff < 0 ||
        (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return age;
}
function resolveHomeType(role, birthday) {
    const age = calculateAge(birthday);
    if (role === 'nguoichamsoc') {
        return {
            age,
            home_type: 'adult',
        };
    }
    if (role === 'nguoiduocchamsoc') {
        if (age !== null && age < 16) {
            return {
                age,
                home_type: 'child',
            };
        }
        if (age !== null && age >= 60) {
            return {
                age,
                home_type: 'elderly',
            };
        }
        return {
            age,
            home_type: 'adult',
        };
    }
    return {
        age,
        home_type: 'adult',
    };
}
class AuthService {
    async login(email, password) {
        const { data, error } = await supabase_1.supabase.auth.signInWithPassword({
            email,
            password,
        });
        if (error || !data.user || !data.session) {
            throw new Error(error?.message || 'Đăng nhập thất bại');
        }
        const uid = data.user.id;
        let { data: profile, error: profileError } = await supabase_1.supabaseAdmin
            .from('user_info')
            .select('*')
            .eq('uid', uid)
            .maybeSingle();
        if (profileError) {
            throw profileError;
        }
        if (!profile) {
            const { data: newProfile, error: insertError } = await supabase_1.supabaseAdmin
                .from('user_info')
                .insert({
                uid,
                email: data.user.email,
                name: '',
                phone: null,
                birthday: null,
                sex: null,
                address: null,
                role: 'nguoiduocchamsoc',
                avata: null,
            })
                .select('*')
                .single();
            if (insertError) {
                throw insertError;
            }
            profile = newProfile;
        }
        const extra = resolveHomeType(profile.role, profile.birthday);
        return {
            access_token: data.session.access_token,
            refresh_token: data.session.refresh_token,
            expires_at: data.session.expires_at,
            user: {
                id: data.user.id,
                email: data.user.email,
            },
            profile,
            ...extra,
        };
    }
    async logout(accessToken) {
        if (!accessToken) {
            throw new Error('Thiếu access token');
        }
        const { error } = await supabase_1.supabase.auth.admin.signOut(accessToken);
        if (error) {
            throw new Error(error.message || 'Đăng xuất thất bại');
        }
        return { success: true };
    }
    async me(uid) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_info')
            .select('*')
            .eq('uid', uid)
            .single();
        if (error || !data) {
            throw new Error(error?.message || 'Không lấy được thông tin người dùng');
        }
        const extra = resolveHomeType(data.role, data.birthday);
        return {
            ...data,
            ...extra,
        };
    }
}
exports.AuthService = AuthService;
