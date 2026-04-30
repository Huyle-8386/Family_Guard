import 'package:family_guard/features/profile_security/domain/entities/profile.dart';
import 'package:family_guard/features/profile_security/domain/entities/update_profile_request.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<Profile> updateProfile(UpdateProfileRequest request);
}
