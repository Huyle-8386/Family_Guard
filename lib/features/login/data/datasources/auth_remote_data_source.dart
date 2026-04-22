import 'dart:convert';

import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/features/login/domain/entities/auth_user.dart';
import 'package:flutter/services.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUser> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  static const _mockAssetPath = 'assets/mock/family_guard_complete_mock_vi.json';

  final AssetBundle _bundle;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final raw = await _bundle.loadString(_mockAssetPath);
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const AuthException('Không đọc được dữ liệu tài khoản mẫu.');
    }

    final familyId = decoded['familyId']?.toString() ??
        (decoded['metadata'] is Map<String, dynamic>
            ? (decoded['metadata'] as Map<String, dynamic>)['familyId']
                ?.toString()
            : null) ??
        '';

    final accounts = decoded['accounts'];
    if (accounts is! List) {
      throw const AuthException('Không tìm thấy danh sách tài khoản mẫu.');
    }

    final normalizedEmail = email.trim().toLowerCase();
    final matchedAccount = accounts
        .whereType<Map>()
        .map((item) => item.map(
              (key, value) => MapEntry(key.toString(), value),
            ))
        .cast<Map<String, dynamic>>()
        .firstWhere(
          (account) =>
              account['email']?.toString().trim().toLowerCase() ==
                  normalizedEmail &&
              account['password']?.toString() == password,
          orElse: () => const <String, dynamic>{},
        );

    if (matchedAccount.isEmpty) {
      throw const AuthException('Email hoặc mật khẩu không đúng.');
    }

    final role = matchedAccount['role']?.toString() ?? '';
    return AuthUser(
      userId: matchedAccount['userId']?.toString() ?? '',
      familyId:
          matchedAccount['familyId']?.toString().trim().isNotEmpty == true
              ? matchedAccount['familyId'].toString()
              : familyId,
      email: matchedAccount['email']?.toString() ?? normalizedEmail,
      displayName: matchedAccount['displayName']?.toString() ?? '',
      role: role,
      roleLabel: matchedAccount['roleLabel']?.toString() ?? '',
      homeRoute: _homeRouteForRole(role),
    );
  }

  String _homeRouteForRole(String role) {
    switch (role) {
      case 'con':
        return AppRoutes.kidHome;
      case 'ba_noi':
        return AppRoutes.seniorHome;
      case 'ba':
      case 'me':
      default:
        return AppRoutes.home;
    }
  }
}
