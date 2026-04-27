import { supabaseAdmin } from '../../config/supabase';

export class NotificationsService {
  private normalizeRelationLabel(value?: string | null): string {
    const normalized = value?.toString().trim();
    return normalized && normalized.length > 0 ? normalized : 'Người thân';
  }

  private async getUserDisplayName(uid: string): Promise<string> {
    const { data: userProfile, error } = await supabaseAdmin
      .from('user_info')
      .select('name')
      .eq('uid', uid)
      .maybeSingle();

    if (error) {
      throw error;
    }

    const displayName = userProfile?.name?.toString().trim();
    return displayName && displayName.length > 0
      ? displayName
      : 'Một thành viên gia đình';
  }

  async listMine(uid: string) {
    const { data, error } = await supabaseAdmin
      .from('notification')
      .select(
        `
          id,
          title,
          content,
          processing,
          uid,
          relationship_id,
          created_at,
          relationship:relationship_id(
            relation_type,
            reverse_relation_type,
            inviter:user_info!relationship_uid_fkey(
              name
            )
          )
        `,
      )
      .eq('uid', uid)
      .order('created_at', { ascending: false });

    if (error) {
      throw error;
    }

    return (data ?? []).map((item: any) => {
      const isPendingInvite = item.processing === 'dagui';

      return {
        id: item.id,
        title: item.title,
        content: item.content,
        processing: item.processing,
        uid: item.uid,
        relationship_id: item.relationship_id,
        created_at: item.created_at,
        sender_name: isPendingInvite ? item.relationship?.inviter?.name ?? null : null,
        sender_relation: isPendingInvite
          ? item.relationship?.reverse_relation_type ??
            item.relationship?.relation_type ??
            null
          : null,
      };
    });
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
            relation_type: relationship.reverse_relation_type ?? 'Người thân',
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

    if (action === 'xacnhan') {
      try {
        const responderName = await this.getUserDisplayName(uid);
        const responderRelation = this.normalizeRelationLabel(
          relationship.relation_type,
        );

        await supabaseAdmin.from('notification').insert({
          uid: relationship.uid,
          relationship_id: relationship.id,
          title: 'Mối quan hệ đã được xác nhận',
          content: `${responderName}(${responderRelation}) đã xác nhận lời mời kết nối gia đình của bạn. Hai người hiện đã được liên kết.`,
          processing: 'done',
        });
      } catch (error) {
        console.error('Không thể tạo thông báo xác nhận cho người gửi lời mời', error);
      }
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
