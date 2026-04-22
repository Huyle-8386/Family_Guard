import { supabaseAdmin } from '../../config/supabase';

export class RelationshipsService {
  async invite(
    uid: string,
    targetUid: string,
    relationType: string,
    reverseRelationType: string,
  ) {
    if (uid === targetUid) {
      throw new Error('Không thể tự thêm chính mình');
    }

    const { data: existed, error: existedError } = await supabaseAdmin
      .from('relationship')
      .select('id, processing')
      .or(
        `and(uid.eq.${uid},relation_id.eq.${targetUid}),and(uid.eq.${targetUid},relation_id.eq.${uid})`,
      )
      .neq('processing', 'daxoa')
      .maybeSingle();

    if (existedError) throw existedError;

    if (existed) {
      throw new Error('Hai người này đã có quan hệ hoặc đang chờ xác nhận');
    }

    const { data: relationship, error: relationshipError } = await supabaseAdmin
      .from('relationship')
      .insert({
        uid,
        relation_id: targetUid,
        relation_type: relationType,
        reverse_relation_type: reverseRelationType,
        processing: 'chuachapnhan',
      })
      .select('*')
      .single();

    if (relationshipError) throw relationshipError;

    const { data: notification, error: notificationError } = await supabaseAdmin
      .from('notification')
      .insert({
        uid: targetUid,
        relationship_id: relationship.id,
        title: 'Xác nhận người thân',
        content: 'Yêu cầu tham gia',
        processing: 'dagui',
      })
      .select('*')
      .single();

    if (notificationError) throw notificationError;

    return {
      relationship,
      notification,
    };
  }

  async listMyRelationships(uid: string) {
    const { data, error } = await supabaseAdmin
      .from('relationship')
      .select(`
        id,
        uid,
        relation_id,
        relation_type,
        reverse_relation_type,
        processing,
        created_at,
        relation_user:user_info!relationship_relation_id_fkey(
          uid,
          name,
          email,
          phone,
          birthday,
          sex,
          address,
          role,
          avata,
          created_at
        )
      `)
      .eq('uid', uid)
      .neq('processing', 'daxoa')
      .order('created_at', { ascending: false });

    if (error) throw error;

    return data;
  }

  async updateRelationship(
    currentUid: string,
    relationshipId: number,
    relationType: string,
    reverseRelationType?: string,
  ) {
    const { data: relationship, error: findError } = await supabaseAdmin
      .from('relationship')
      .select('*')
      .eq('id', relationshipId)
      .single();

    if (findError || !relationship) {
      throw new Error('Không tìm thấy relationship');
    }

    if (relationship.uid !== currentUid) {
      throw new Error('Bạn không có quyền sửa relationship này');
    }

    if (relationship.processing === 'daxoa') {
      throw new Error('Relationship này đã bị xóa');
    }
if (relationship.processing === 'huy') {
      throw new Error('Relationship này đã bị hủy');
    }

    const updatePayload: Record<string, any> = {
      relation_type: relationType,
    };

    if (reverseRelationType) {
      updatePayload.reverse_relation_type = reverseRelationType;
    }

    const { data, error } = await supabaseAdmin
      .from('relationship')
      .update(updatePayload)
      .eq('id', relationshipId)
      .select('*')
      .single();

    if (error) throw error;

    if (relationship.processing === 'xacnhan') {
      const { error: reverseError } = await supabaseAdmin
        .from('relationship')
        .update({
          relation_type:
            reverseRelationType ?? relationship.reverse_relation_type,
          reverse_relation_type: relationType,
        })
        .eq('uid', relationship.relation_id)
        .eq('relation_id', relationship.uid)
        .neq('processing', 'daxoa');

      if (reverseError) throw reverseError;
    }

    return data;
  }

  async deleteRelationship(currentUid: string, relationshipId: number) {
    const { data: relationship, error: findError } = await supabaseAdmin
      .from('relationship')
      .select('*')
      .eq('id', relationshipId)
      .single();

    if (findError || !relationship) {
      throw new Error('Không tìm thấy relationship');
    }

    if (relationship.uid !== currentUid) {
      throw new Error('Bạn không có quyền xóa relationship này');
    }

    if (relationship.processing === 'daxoa') {
      throw new Error('Relationship này đã bị xóa rồi');
    }

    const { data, error } = await supabaseAdmin
      .from('relationship')
      .update({
        processing: 'daxoa',
      })
      .eq('id', relationshipId)
      .select('*')
      .single();

    if (error) throw error;

    await supabaseAdmin
      .from('relationship')
      .update({
        processing: 'daxoa',
      })
      .eq('uid', relationship.relation_id)
      .eq('relation_id', relationship.uid)
      .neq('processing', 'daxoa');

    return data;
  }
}
