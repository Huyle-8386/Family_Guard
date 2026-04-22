import 'package:family_guard/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:family_guard/features/login/domain/entities/auth_user.dart';
import 'package:family_guard/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);

  final AuthRemoteDataSource _remote;

  @override
  Future<AuthUser> login({required String email, required String password}) {
    return _remote.login(email: email, password: password);
  }
}
