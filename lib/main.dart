import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/routes/app_router.dart';
import 'package:family_guard/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.login,
      routes: AppRouter.routes,
    );
  }
}
