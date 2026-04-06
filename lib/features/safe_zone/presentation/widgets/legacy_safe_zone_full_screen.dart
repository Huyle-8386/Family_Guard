import 'package:flutter/material.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/legacy_safe_zone_scope.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_screen.dart'
    as legacy_safe_zone;

class LegacySafeZoneFullScreen extends StatelessWidget {
  const LegacySafeZoneFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegacySafeZoneScope(
      child: legacy_safe_zone.SafeZoneScreen(),
    );
  }
}
