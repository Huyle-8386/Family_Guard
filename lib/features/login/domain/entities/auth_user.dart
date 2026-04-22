class AuthUser {
  const AuthUser({
    required this.userId,
    required this.familyId,
    required this.email,
    required this.displayName,
    required this.role,
    required this.roleLabel,
    required this.homeRoute,
  });

  final String userId;
  final String familyId;
  final String email;
  final String displayName;
  final String role;
  final String roleLabel;
  final String homeRoute;
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
