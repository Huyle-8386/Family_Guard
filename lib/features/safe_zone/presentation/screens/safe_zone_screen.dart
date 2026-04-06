import 'package:flutter/material.dart';
import 'package:family_guard/features/safe_zone/presentation/screens/safe_zone_overview_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/legacy_safe_zone_scope.dart';

class SafeZoneScreen extends StatelessWidget {
  const SafeZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegacySafeZoneScope(
      child: SafeZoneOverviewScreen(),
    );
  }
}
