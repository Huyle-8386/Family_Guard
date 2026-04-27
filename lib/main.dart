import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/fall_detection/data/fall_detection_service.dart';
import 'package:family_guard/core/fall_detection/presentation/fall_detection_controller.dart';
import 'package:family_guard/core/routes/app_router.dart';
import 'package:family_guard/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  void initState() {
    super.initState();
    FallDetectionController.instance.bind(FallDetectionService.instance);
    FallDetectionController.instance.addListener(_onFallEvent);
  }

  @override
  void dispose() {
    FallDetectionController.instance.removeListener(_onFallEvent);
    FallDetectionController.instance.unbind();
    super.dispose();
  }

  void _onFallEvent() {
    final event = FallDetectionController.instance.value;
    if (event == null) return;

    final messengerState = _scaffoldMessengerKey.currentState;
    if (messengerState == null) return;

    messengerState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Possible fall detected (${event.probability.toStringAsFixed(2)})',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.login,
      routes: AppRouter.routes,
    );
  }
}
