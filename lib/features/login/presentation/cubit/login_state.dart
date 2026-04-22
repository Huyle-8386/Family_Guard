import 'package:family_guard/features/login/domain/entities/auth_user.dart';

class LoginState {
  const LoginState({
    this.isLoading = false,
    this.obscurePassword = true,
    this.errorMessage,
    this.user,
  });

  final bool isLoading;
  final bool obscurePassword;
  final String? errorMessage;
  final AuthUser? user;

  LoginState copyWith({
    bool? isLoading,
    bool? obscurePassword,
    String? errorMessage,
    AuthUser? user,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      user: clearUser ? null : (user ?? this.user),
    );
  }
}
