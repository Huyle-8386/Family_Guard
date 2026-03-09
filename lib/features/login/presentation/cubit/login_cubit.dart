import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/validators.dart';
import 'package:family_guard/features/login/domain/usecases/login_usecase.dart';
import 'package:family_guard/features/login/presentation/cubit/login_state.dart';

class LoginCubit extends ChangeNotifier {
  LoginCubit(this._loginUseCase);

  final LoginUseCase _loginUseCase;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginState _state = const LoginState();
  LoginState get state => _state;

  String? validateEmail(String? value) => Validators.email(value);

  String? validatePassword(String? value) => Validators.password(value);

  void togglePasswordVisibility() {
    _state = _state.copyWith(obscurePassword: !_state.obscurePassword);
    notifyListeners();
  }

  Future<bool> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return false;
    }

    _state = _state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      await _loginUseCase(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      _state = _state.copyWith(isLoading: false, clearError: true);
      notifyListeners();
      return true;
    } catch (_) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Đăng nhập thất bại. Vui lòng thử lại.',
      );
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
