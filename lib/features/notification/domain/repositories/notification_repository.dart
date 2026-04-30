import 'package:family_guard/features/notification/domain/entities/app_notification.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
  Future<AppNotification> respondNotification({
    required int id,
    required String action,
  });
}
