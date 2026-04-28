"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.safeZonesService = exports.SafeZonesService = void 0;
const supabase_1 = require("../../config/supabase");
class SafeZonesService {
    async createSafeZone(ownerUid, input) {
        await this.ensureCaregiver(ownerUid);
        await this.ensureConfirmedRelationship(ownerUid, input.target_uid);
        const { data, error } = await supabase_1.supabaseAdmin
            .from('safe_zones')
            .insert({
            owner_uid: ownerUid,
            target_uid: input.target_uid,
            name: input.name.trim(),
            center_latitude: input.center_latitude,
            center_longitude: input.center_longitude,
            radius_meters: input.radius_meters,
            is_active: input.is_active ?? true,
        })
            .select('*')
            .single();
        if (error || !data) {
            throw new Error(error?.message || 'Khong tao duoc safe zone');
        }
        return data;
    }
    async listSafeZones(uid) {
        const role = await this.getUserRole(uid);
        let query = supabase_1.supabaseAdmin
            .from('safe_zones')
            .select('*')
            .order('updated_at', { ascending: false });
        if (role === 'nguoichamsoc') {
            query = query.eq('owner_uid', uid);
        }
        else {
            query = query.eq('target_uid', uid);
        }
        const { data, error } = await query;
        if (error) {
            throw new Error(error.message || 'Khong lay duoc safe zones');
        }
        return (data ?? []);
    }
    async updateSafeZone(ownerUid, id, input) {
        const existing = await this.getOwnedSafeZone(ownerUid, id);
        const updatePayload = {
            updated_at: new Date().toISOString(),
        };
        if (input.name != null) {
            updatePayload.name = input.name.trim();
        }
        if (input.center_latitude != null) {
            updatePayload.center_latitude = input.center_latitude;
        }
        if (input.center_longitude != null) {
            updatePayload.center_longitude = input.center_longitude;
        }
        if (input.radius_meters != null) {
            updatePayload.radius_meters = input.radius_meters;
        }
        if (input.is_active != null) {
            updatePayload.is_active = input.is_active;
        }
        const { data, error } = await supabase_1.supabaseAdmin
            .from('safe_zones')
            .update(updatePayload)
            .eq('id', existing.id)
            .select('*')
            .single();
        if (error || !data) {
            throw new Error(error?.message || 'Khong cap nhat duoc safe zone');
        }
        return data;
    }
    async deleteSafeZone(ownerUid, id) {
        const existing = await this.getOwnedSafeZone(ownerUid, id);
        const { data, error } = await supabase_1.supabaseAdmin
            .from('safe_zones')
            .delete()
            .eq('id', existing.id)
            .select('*')
            .single();
        if (error || !data) {
            throw new Error(error?.message || 'Khong xoa duoc safe zone');
        }
        return data;
    }
    async checkLocationForUser(uid, latitude, longitude) {
        const { data: zones, error } = await supabase_1.supabaseAdmin
            .from('safe_zones')
            .select('*')
            .eq('target_uid', uid)
            .eq('is_active', true);
        if (error) {
            throw new Error(error.message || 'Khong kiem tra duoc safe zone');
        }
        if (!zones || zones.length == 0) {
            return;
        }
        const memberName = await this.getUserDisplayName(uid);
        for (const rawZone of zones) {
            const zone = rawZone;
            const distance = this.calculateDistanceMeters(latitude, longitude, zone.center_latitude, zone.center_longitude);
            const isInside = distance <= zone.radius_meters;
            const { data: existingState, error: stateError } = await supabase_1.supabaseAdmin
                .from('safe_zone_states')
                .select('*')
                .eq('safe_zone_id', zone.id)
                .eq('uid', uid)
                .maybeSingle();
            if (stateError) {
                throw new Error(stateError.message || 'Khong doc duoc safe zone state');
            }
            const nowIso = new Date().toISOString();
            if (!existingState) {
                const { error: insertStateError } = await supabase_1.supabaseAdmin
                    .from('safe_zone_states')
                    .insert({
                    safe_zone_id: zone.id,
                    uid,
                    is_inside: isInside,
                    last_checked_at: nowIso,
                });
                if (insertStateError) {
                    throw new Error(insertStateError.message || 'Khong tao duoc safe zone state');
                }
                continue;
            }
            const state = existingState;
            if (state.is_inside === isInside) {
                const { error: refreshStateError } = await supabase_1.supabaseAdmin
                    .from('safe_zone_states')
                    .update({
                    is_inside: isInside,
                    last_checked_at: nowIso,
                })
                    .eq('id', state.id);
                if (refreshStateError) {
                    throw new Error(refreshStateError.message || 'Khong cap nhat duoc safe zone state');
                }
                continue;
            }
            const { error: updateStateError } = await supabase_1.supabaseAdmin
                .from('safe_zone_states')
                .update({
                is_inside: isInside,
                last_checked_at: nowIso,
                last_notified_at: nowIso,
            })
                .eq('id', state.id);
            if (updateStateError) {
                throw new Error(updateStateError.message || 'Khong cap nhat duoc safe zone state');
            }
            const relationshipId = await this.findRelationshipId(zone.owner_uid, zone.target_uid);
            const title = isInside
                ? 'Thanh vien da quay lai vung an toan'
                : 'Canh bao vung an toan';
            const content = isInside
                ? `${memberName} da quay lai vung an toan ${zone.name}`
                : `${memberName} da roi khoi vung an toan ${zone.name}`;
            const { error: notificationError } = await supabase_1.supabaseAdmin
                .from('notification')
                .insert({
                title,
                content,
                processing: 'dagui',
                uid: zone.owner_uid,
                relationship_id: relationshipId,
            });
            if (notificationError) {
                throw new Error(notificationError.message || 'Khong tao duoc notification safe zone');
            }
        }
    }
    calculateDistanceMeters(lat1, lon1, lat2, lon2) {
        const toRad = (value) => (value * Math.PI) / 180;
        const earthRadius = 6371000;
        const dLat = toRad(lat2 - lat1);
        const dLon = toRad(lon2 - lon1);
        const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(toRad(lat1)) *
                Math.cos(toRad(lat2)) *
                Math.sin(dLon / 2) *
                Math.sin(dLon / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return earthRadius * c;
    }
    async ensureCaregiver(uid) {
        const role = await this.getUserRole(uid);
        if (role !== 'nguoichamsoc') {
            throw new Error('Chi nguoi cham soc moi duoc tao vung an toan');
        }
    }
    async getUserRole(uid) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_info')
            .select('role')
            .eq('uid', uid)
            .maybeSingle();
        if (error) {
            throw new Error(error.message || 'Khong lay duoc role nguoi dung');
        }
        return data?.role ?? null;
    }
    async ensureConfirmedRelationship(ownerUid, targetUid) {
        const relationshipId = await this.findRelationshipId(ownerUid, targetUid);
        if (relationshipId == null) {
            throw new Error('Hai nguoi dung chua co quan he da xac nhan');
        }
    }
    async findRelationshipId(ownerUid, targetUid) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('relationship')
            .select('id')
            .or(`and(uid.eq.${ownerUid},relation_id.eq.${targetUid},processing.eq.xacnhan),and(uid.eq.${targetUid},relation_id.eq.${ownerUid},processing.eq.xacnhan)`)
            .order('id', { ascending: true })
            .limit(1)
            .maybeSingle();
        if (error) {
            throw new Error(error.message || 'Khong lay duoc relationship');
        }
        return typeof data?.id === 'number' ? data.id : null;
    }
    async getOwnedSafeZone(ownerUid, id) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('safe_zones')
            .select('*')
            .eq('id', id)
            .eq('owner_uid', ownerUid)
            .maybeSingle();
        if (error) {
            throw new Error(error.message || 'Khong tim thay safe zone');
        }
        if (!data) {
            throw new Error('Ban khong co quyen sua safe zone nay');
        }
        return data;
    }
    async getUserDisplayName(uid) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('user_info')
            .select('name, email')
            .eq('uid', uid)
            .maybeSingle();
        if (error) {
            throw new Error(error.message || 'Khong lay duoc ten nguoi dung');
        }
        const name = data?.name?.toString().trim();
        if (name) {
            return name;
        }
        const email = data?.email?.toString().trim();
        return email || 'Thanh vien gia dinh';
    }
}
exports.SafeZonesService = SafeZonesService;
exports.safeZonesService = new SafeZonesService();
