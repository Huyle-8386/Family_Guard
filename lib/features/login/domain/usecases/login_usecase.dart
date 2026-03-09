import 'package:family_guard/features/login/domain/entities/auth_user.dart';
import 'package:family_guard/features/login/domain/repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({required String email, required String password}) {
    return _repository.login(email: email, password: password);
  }
}
