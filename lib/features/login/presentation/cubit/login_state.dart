class LoginState {
  const LoginState({
    this.isLoading = false,
    this.obscurePassword = true,
    this.errorMessage,
  });

  final bool isLoading;
  final bool obscurePassword;
  final String? errorMessage;

  LoginState copyWith({
    bool? isLoading,
    bool? obscurePassword,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
