import 'package:flutter/material.dart';
import 'package:family_guard/lib/features/safe_zone/data/datasources/safe_zone_service.dart';

class LegacySafeZoneScope extends StatelessWidget {
  const LegacySafeZoneScope({
    super.key,
    required this.child,
  });

  final Widget child;

  static final SafeZoneService _service = SafeZoneService();

  @override
  Widget build(BuildContext context) {
    return SafeZoneProvider(
      service: _service,
      child: child,
    );
  }
}
