import 'package:family_guard/features/login/domain/entities/auth_user.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUser> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthUser> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return AuthUser(email: email);
  }
}
