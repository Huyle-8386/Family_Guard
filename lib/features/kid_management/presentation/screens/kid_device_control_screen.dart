import 'package:family_guard/features/kid_management/presentation/shared/kid_management_data.dart';
import 'package:family_guard/features/kid_management/presentation/shared/kid_management_ui.dart';
import 'package:flutter/material.dart';

class KidDeviceControlScreen extends StatefulWidget {
  const KidDeviceControlScreen({super.key});

  @override
  State<KidDeviceControlScreen> createState() => _KidDeviceControlScreenState();
}

class _KidDeviceControlScreenState extends State<KidDeviceControlScreen> {
  bool _deviceLocked = false;
  bool _internetEnabled = true;
  bool _installEnabled = true;
  bool _locationEnabled = true;
  String _lastUpdated = '2 ph�t tru?c';

  @override
  Widget build(BuildContext context) {
    return KidDetailScaffold(
      title: '�i?u khi?n thi?t b?',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF5F4),
              borderRadius: BorderRadius.circular(48),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thi?t b? dang ho?t d?ng',
                        style: kidTextStyle(
                          size: 14,
                          weight: FontWeight.w500,
                          color: const Color(0xFF3C4949),
                          height: 20 / 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'iPhone 15 Pro',
                        style: kidTextStyle(
                          size: 24,
                          weight: FontWeight.w700,
                          color: const Color(0xFF171D1D),
                          height: 32 / 24,
                          letterSpacing: -0.6,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF01ADB2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '�U?C GI�M S�T',
                            style: kidTextStyle(
                              size: 12,
                              weight: FontWeight.w500,
                              color: const Color(0xFF3C4949),
                              height: 16 / 12,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6BE9B),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Icon(
                    Icons.smartphone_rounded,
                    color: Color(0xFF334155),
                    size: 44,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'TRUNG T�M �I?U KHI?N',
            style: kidTextStyle(
              size: 12,
              weight: FontWeight.w600,
              color: const Color(0xFF3C4949),
              height: 16 / 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          KidSurfaceCard(
            padding: const EdgeInsets.all(20),
            radius: 32,
            child: Column(
              children: [
                KidDeviceToggleRow(
                  icon: Icons.lock_outline_rounded,
                  iconBackground: const Color(0xFFE3E9E9),
                  title: 'Kh�a thi?t b?',
                  subtitle: 'Kh�a thi?t b? t? xa t?c th�',
                  value: _deviceLocked,
                  onChanged: (value) => setState(() => _deviceLocked = value),
                ),
                const SizedBox(height: 24),
                KidDeviceToggleRow(
                  icon: Icons.wifi_rounded,
                  iconBackground: const Color(0x4DBDEBEC),
                  title: 'Truy c?p Internet',
                  subtitle: 'Qu?n l� k?t n?i',
                  value: _internetEnabled,
                  onChanged: (value) =>
                      setState(() => _internetEnabled = value),
                ),
                const SizedBox(height: 24),
                KidDeviceToggleRow(
                  icon: Icons.apps_rounded,
                  iconBackground: const Color(0xFFE3E9E9),
                  title: 'T?i ?ng d?ng',
                  subtitle: 'Cho ph�p t?i ?ng d?ng',
                  value: _installEnabled,
                  onChanged: (value) => setState(() => _installEnabled = value),
                ),
                const SizedBox(height: 24),
                KidDeviceToggleRow(
                  icon: Icons.location_on_rounded,
                  iconBackground: const Color(0xFFE3E9E9),
                  title: 'V? tr�',
                  subtitle: 'K�ch ho?t theo d�i v? tr�',
                  value: _locationEnabled,
                  onChanged: (value) =>
                      setState(() => _locationEnabled = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: KidInfoGridCard(
                  leading: Row(
                    children: [
                      const Icon(
                        Icons.battery_3_bar_rounded,
                        size: 18,
                        color: Color(0xFF171D1D),
                      ),
                      const Spacer(),
                      Text(
                        '78%',
                        style: kidTextStyle(
                          size: 12,
                          weight: FontWeight.w700,
                          color: const Color(0xFF171D1D),
                          height: 16 / 12,
                        ),
                      ),
                    ],
                  ),
                  label: 'Pin',
                  value: 'T?i uu',
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: KidInfoGridCard(
                  leading: Icon(
                    Icons.update_rounded,
                    size: 18,
                    color: Color(0xFF171D1D),
                  ),
                  label: 'Phi�n b?n',
                  value: 'iOS 17.4',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          KidSurfaceCard(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            radius: 32,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EFEF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.sync_rounded,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'L?n cu?i c?p nh?t',
                        style: kidTextStyle(
                          size: 12,
                          weight: FontWeight.w500,
                          color: const Color(0xFF3C4949),
                          height: 16 / 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _lastUpdated,
                        style: kidTextStyle(
                          size: 14,
                          weight: FontWeight.w600,
                          color: const Color(0xFF171D1D),
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
                KidFilledPillButton(
                  label: 'T?i l?i',
                  backgroundColor: const Color(0x3301ADB2),
                  foregroundColor: const Color(0xFF171D1D),
                  onTap: () => setState(() => _lastUpdated = 'V?a xong'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _showPauseDialog(context),
            borderRadius: BorderRadius.circular(48),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0x4DFFDAD6),
                borderRadius: BorderRadius.circular(48),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.pause_circle_outline_rounded,
                    color: Color(0xFFBA1A1A),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'T?m d?ng m?i ho?t d?ng',
                    style: kidTextStyle(
                      size: 16,
                      weight: FontWeight.w600,
                      color: const Color(0xFFBA1A1A),
                      height: 24 / 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPauseDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 38),
          child: Container(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 50,
                  offset: Offset(0, 25),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0x1AFF6B6B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.pause_circle_outline_rounded,
                    color: Color(0xFFDC2626),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'T?m d?ng m?i ho?t d?ng',
                  textAlign: TextAlign.center,
                  style: kidTextStyle(
                    size: 20,
                    weight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    height: 28 / 20,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Thi?t b? s? b? v� hi?u h�a ngay l?p t?c',
                  textAlign: TextAlign.center,
                  style: kidTextStyle(
                    size: 16,
                    weight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                    height: 26 / 16,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Thi?t b? d� du?c chuy?n sang ch? d? t?m d?ng.',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      foregroundColor: Colors.white,
                      elevation: 12,
                      shadowColor: const Color(0x3319A7A8),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'T?m d?ng',
                      style: kidTextStyle(
                        size: 16,
                        weight: FontWeight.w600,
                        color: Colors.white,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'H?y',
                    style: kidTextStyle(
                      size: 16,
                      weight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                      height: 24 / 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
