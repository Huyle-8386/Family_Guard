class ApiEndpoints {
  const ApiEndpoints._();

  static const String authLogin = '/auth/login';
  static const String authLogout = '/auth/logout';
  static const String authMe = '/auth/me';

  static const String me = '/me';
  static const String usersSearch = '/users/search';

  static const String relationships = '/relationships';
  static const String relationshipsInvite = '/relationships/invite';

  static const String notifications = '/notifications';

  static String relationshipById(int id) => '$relationships/$id';

  static String notificationRespond(int id) => '$notifications/$id/respond';
}
