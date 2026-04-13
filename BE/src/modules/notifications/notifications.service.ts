import { supabaseAdmin } from '../../config/supabase';

export class NotificationsService {
  async listMine(uid: string) {
    const { data, error } = await supabaseAdmin
      .from('notification')
      .select('*')
      .eq('uid', uid)
      .order('created_at', { ascending: false });

    if (error) {
      throw error;
    }

    return data;
  }

  async respond(
    uid: string,
    notificationId: number,
    action: 'xacnhan' | 'huy',
  ) {
    const { data: notification, error: notificationError } = await supabaseAdmin
      .from('notification')
      .select('*')
      .eq('id', notificationId)
      .eq('uid', uid)
      .single();

    if (notificationError || !notification) {
      throw new Error('Không tìm thấy notification');
    }

    if (notification.processing !== 'dagui') {
      throw new Error('Notification này đã được xử lý');
    }

    if (!notification.relationship_id) {
      throw new Error('Notification không gắn với relationship');
    }

    const { data: relationship, error: relationshipFetchError } =
      await supabaseAdmin
        .from('relationship')
        .select('*')
        .eq('id', notification.relationship_id)
        .single();

    if (relationshipFetchError || !relationship) {
      throw new Error('Không tìm thấy relationship');
    }

    if (relationship.relation_id !== uid) {
      throw new Error('Bạn không có quyền xử lý lời mời này');
    }

    const newRelationshipStatus = action === 'xacnhan' ? 'xacnhan' : 'huy';

    const { error: relationshipError } = await supabaseAdmin
      .from('relationship')
      .update({ processing: newRelationshipStatus })
      .eq('id', notification.relationship_id);

    if (relationshipError) {
      throw relationshipError;
    }

    if (action === 'xacnhan') {
      const { error: reverseInsertError } = await supabaseAdmin
        .from('relationship')
        .upsert(
          {
            uid: relationship.relation_id,
            relation_id: relationship.uid,
            relation_type:
              relationship.reverse_relation_type ?? 'Người thân',
            reverse_relation_type: relationship.relation_type,
            processing: 'xacnhan',
          },
          {
            onConflict: 'uid,relation_id',
          },
        );

      if (reverseInsertError) {
        throw reverseInsertError;
      }
    }

    if (action === 'huy') {
      await supabaseAdmin
        .from('relationship')
        .update({ processing: 'huy' })
        .eq('uid', relationship.relation_id)
        .eq('relation_id', relationship.uid);
    }

    const { data: updatedNotification, error: updateNotificationError } =
      await supabaseAdmin
        .from('notification')
        .update({ processing: 'done' })
        .eq('id', notificationId)
        .select('*')
        .single();

    if (updateNotificationError) {
      throw updateNotificationError;
    }

    return updatedNotification;
  }
}