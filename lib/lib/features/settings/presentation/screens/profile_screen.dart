import 'package:flutter/material.dart';
import 'package:family_guard/lib/core/utils/responsive/responsive_helper.dart';
import 'package:family_guard/lib/core/widgets/app_dialog.dart';
import 'package:family_guard/lib/core/theme/theme.dart';


/// ============================================================
/// PROFILE SCREEN - Template
/// Paste code Widget tá»« Figma Dev Mode vÃ o Ä‘Ã¢y
/// ============================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final avatarRadius = ResponsiveHelper.wp(context, 13).clamp(40.0, 64.0);
    final h3Sz = ResponsiveHelper.sp(context, 20);
    final bodyMdSz = ResponsiveHelper.sp(context, 14);
    final captionSz = ResponsiveHelper.sp(context, 12);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Há»“ sÆ¡',
          style: TextStyle(fontSize: ResponsiveHelper.sp(context, 18)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined,
                size: ResponsiveHelper.sp(context, 24)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('CÃ i Ä‘áº·t sáº½ Ä‘Æ°á»£c cáº­p nháº­t')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // === AVATAR ===
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: avatarRadius,
                      color: AppColors.primary,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: ResponsiveHelper.sp(context, 16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // === NAME ===
            Text(
              'Nguyen Van A',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textPrimary,
                fontSize: h3Sz,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'nguyenvana@email.com',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontSize: bodyMdSz,
              ),
            ),
            const SizedBox(height: 24),

            // === STATS ROW ===
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Row(
                children: [
                  _buildStat(context, '12', 'Dá»± Ã¡n', h3Sz, captionSz),
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.border,
                  ),
                  _buildStat(context, '48', 'Widget', h3Sz, captionSz),
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.border,
                  ),
                  _buildStat(context, '156', 'Thiáº¿t káº¿', h3Sz, captionSz),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // === MENU ITEMS ===
            _buildMenuItem(context, Icons.person_outline, 'ThÃ´ng tin cÃ¡ nhÃ¢n'),
            _buildMenuItem(context, Icons.notifications_outlined, 'ThÃ´ng bÃ¡o'),
            _buildMenuItem(context, Icons.palette_outlined, 'Giao diá»‡n'),
            _buildMenuItem(context, Icons.security_outlined, 'Báº£o máº­t'),
            _buildMenuItem(context, Icons.help_outline, 'Trá»£ giÃºp'),
            _buildMenuItem(context, Icons.info_outline, 'Vá» á»©ng dá»¥ng'),
            const SizedBox(height: 16),

            // === LOGOUT BUTTON ===
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      type: AppDialogType.delete,
                      title: 'XÃ¡c nháº­n',
                      content: 'Báº¡n cÃ³ cháº¯c muá»‘n Ä‘Äƒng xuáº¥t?',
                      confirmText: 'ÄÄƒng xuáº¥t',
                      icon: Icons.logout_rounded,
                      onConfirm: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
                      },
                    );
                  },
                  child: Text(
                    'ÄÄƒng xuáº¥t',
                    style: AppTextStyles.button.copyWith(
                      color: Colors.white,
                      fontSize: ResponsiveHelper.sp(context, 14),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label,
      double valSz, double lblSz) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.primary,
              fontSize: valSz,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: lblSz,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final iconSz = ResponsiveHelper.sp(context, 20);
    final titleSz = ResponsiveHelper.sp(context, 16);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: hPad, vertical: 4),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: iconSz),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
          fontSize: titleSz,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textHint,
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title - sáº½ Ä‘Æ°á»£c cáº­p nháº­t')),
        );
      },
    );
  }
}


