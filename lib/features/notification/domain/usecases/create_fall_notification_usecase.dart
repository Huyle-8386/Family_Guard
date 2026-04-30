import 'package:family_guard/features/notification/domain/repositories/notification_repository.dart';

class CreateFallNotificationUseCase {
  CreateFallNotificationUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call() {
    return _repository.createFallNotification();
  }
}
