import 'package:family_guard/features/location_tracking/domain/entities/user_location.dart';
import 'package:family_guard/features/notification/domain/repositories/notification_repository.dart';

class GetFallAlertLocationUseCase {
  GetFallAlertLocationUseCase(this._repository);

  final NotificationRepository _repository;

  Future<UserLocation?> call(int id) {
    return _repository.getFallAlertLocation(id);
  }
}
