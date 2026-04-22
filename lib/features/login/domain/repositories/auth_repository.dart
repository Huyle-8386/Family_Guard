import 'package:family_guard/features/login/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login({required String email, required String password});
}
