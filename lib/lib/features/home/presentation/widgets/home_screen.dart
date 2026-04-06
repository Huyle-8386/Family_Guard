import 'package:family_guard/lib/core/routes/app_routes.dart';
import 'package:family_guard/lib/core/theme/app_colors.dart';
import 'package:family_guard/lib/core/theme/app_text_styles.dart';
import 'package:family_guard/lib/core/utils/responsive/responsive_helper.dart';
import 'package:family_guard/lib/core/theme/app_shadows.dart';
import 'package:flutter/material.dart';

/// ============================================================
/// HOME SCREEN
/// Paste code Widget tá»« Figma Dev Mode vÃ o Ä‘Ã¢y
/// ============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pagePad = ResponsiveHelper.pagePadding(context);
    final cols = ResponsiveHelper.gridColumns(context);
    final h2Size = ResponsiveHelper.sp(context, 24);
    final h3Size = ResponsiveHelper.sp(context, 20);
    final h4Size = ResponsiveHelper.sp(context, 18);
    final bodyMdSize = ResponsiveHelper.sp(context, 14);
    final bodySmSize = ResponsiveHelper.sp(context, 12);
    final labelLgSize = ResponsiveHelper.sp(context, 14);
    final iconContainerSz = ResponsiveHelper.sp(context, 28);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Figma App',
          style: TextStyle(fontSize: ResponsiveHelper.sp(context, 18)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined,
                size: ResponsiveHelper.sp(context, 24)),
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('ChÆ°a cÃ³ thÃ´ng bÃ¡o má»›i',
                      style: TextStyle(fontFamily: 'Lexend')),
                  behavior: SnackBarBehavior.floating,
                ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: pagePad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === WELCOME SECTION ===
              Text(
                'Xin chÃ o! ðŸ‘‹',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: h2Size,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ChÃ o má»«ng báº¡n Ä‘áº¿n vá»›i á»©ng dá»¥ng',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: bodyMdSize,
                ),
              ),
              const SizedBox(height: 24),

              // === SEARCH BAR ===
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                    decoration: const InputDecoration(
                      hintText: 'TÃ¬m kiáº¿m...',
                      prefixIcon: Icon(Icons.search, color: AppColors.textHint),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // === FEATURED CARD ===
              Container(
                padding: ResponsiveHelper.cardPadding(context),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppShadows.small,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Báº¯t Ä‘áº§u ngay',
                            style: AppTextStyles.h3.copyWith(
                              color: Colors.white,
                              fontSize: h3Size,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Paste code Widget tá»« Figma Dev Mode vÃ o project nÃ y',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: bodySmSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: ResponsiveHelper.sp(context, 24),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // === SECTION TITLE ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Danh má»¥c',
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: h4Size,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.reminderManagement);
                    },
                    child: const Text('Xem táº¥t cáº£'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // === GRID ITEMS - adaptive column count ===
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: List.generate(4, (index) {
                  const routes = [
                    AppRoutes.reminderManagement,
                    AppRoutes.physicalActivity,
                    AppRoutes.safeZoneManagement, // qua mÃ n hÃ¬nh tá»•ng quan vÃ¹ng an toÃ n
                    AppRoutes.profile,
                  ];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, routes[index]);
                    },
                    child: Container(
                      padding: ResponsiveHelper.cardPadding(context),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: AppShadows.small,
                      ),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            [
                              Icons.notifications_active_rounded,
                              Icons.directions_run_rounded,
                              Icons.shield_rounded,
                              Icons.person_rounded,
                            ][index],
                            color: AppColors.primary,
                            size: iconContainerSz,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ['Nháº¯c nhá»Ÿ', 'Hoáº¡t Ä‘á»™ng', 'VÃ¹ng an toÃ n', 'CÃ¡ nhÃ¢n'][index],
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: labelLgSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              ),
              const SizedBox(height: 24),

              // === BUTTONS DEMO ===
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.reminderManagement);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Quáº£n lÃ½ nháº¯c nhá»Ÿ',
                    style: AppTextStyles.button.copyWith(
                      color: Colors.white,
                      fontSize: ResponsiveHelper.sp(context, 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.physicalActivity);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Hoáº¡t Ä‘á»™ng thá»ƒ cháº¥t',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.primary,
                      fontSize: ResponsiveHelper.sp(context, 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),

      // === BOTTOM NAVIGATION ===
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chá»§',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'KhÃ¡m phÃ¡',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'YÃªu thÃ­ch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'CÃ¡ nhÃ¢n',
          ),
        ],
      ),
    );
  }
}
