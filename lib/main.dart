import 'dart:async';

import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/di/app_dependencies.dart';
import 'package:family_guard/core/fall_detection/data/fall_detection_service.dart';
import 'package:family_guard/core/fall_detection/presentation/fall_detection_controller.dart';
import 'package:family_guard/core/routes/app_route_observer.dart';
import 'package:family_guard/core/routes/app_router.dart';
import 'package:family_guard/core/theme/app_theme.dart';
import 'package:family_guard/features/home/presentation/widgets/senior_home/senior_sos_sheet.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.instance.initialize();
  await FallDetectionService.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  bool _isSosSheetOpen = false;

  @override
  void initState() {
    super.initState();
    FallDetectionController.instance.bind(FallDetectionService.instance);
    FallDetectionController.instance.addListener(_onFallEvent);
    _restoreFallMonitoringIfNeeded();
  }

  @override
  void dispose() {
    FallDetectionController.instance.removeListener(_onFallEvent);
    FallDetectionController.instance.unbind();
    super.dispose();
  }

  Future<void> _restoreFallMonitoringIfNeeded() async {
    final session = await AppDependencies.instance.getSavedSessionUseCase();
    if (!mounted) {
      return;
    }

    if (session?.homeType == 'elderly') {
      if (!FallDetectionService.instance.isRunning) {
        FallDetectionService.instance.startMonitoring();
      }
    } else {
      await FallDetectionService.instance.stopMonitoring();
    }
  }

  void _onFallEvent() {
    final event = FallDetectionController.instance.value;
    if (event == null || _isSosSheetOpen) return;

    final navigatorState = _navigatorKey.currentState;
    final navigatorContext = navigatorState?.context;
    if (navigatorContext == null) {
      return;
    }

    _isSosSheetOpen = true;
    showModalBottomSheet<void>(
      context: navigatorContext,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => SeniorSosSheet(
        onSafeTap: () {
          Navigator.of(navigatorContext).maybePop();
        },
        onEmergencyTap: () async {
          try {
            await AppDependencies.instance.createFallNotificationUseCase();
          } catch (_) {
            // The senior alert sheet remains visible even if notification delivery fails.
          }
        },
      ),
    ).whenComplete(() {
      _isSosSheetOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.login,
      routes: AppRouter.routes,
      navigatorObservers: [appRouteObserver],
    );
  }
}
