import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/features/checkin_reminder/presentation/screens/checkin_reminder_screen.dart';
import 'package:family_guard/features/checkin_reminder/presentation/widgets/checkin_reminder_selected_screen.dart';
import 'package:family_guard/features/emotion/presentation/screens/emotion_pulse_screen.dart';
import 'package:family_guard/features/emotion/presentation/widgets/emotion_journal_screen.dart';
import 'package:family_guard/features/home/presentation/screens/homepage.dart';
import 'package:family_guard/features/login/presentation/screens/forgot_password_screen.dart';
import 'package:family_guard/features/login/presentation/screens/login_screen.dart';
import 'package:family_guard/features/member_management/presentation/screens/member_management_screen.dart';
import 'package:family_guard/features/member_management/presentation/widgets/add_member_screen.dart';
import 'package:family_guard/features/member_management/presentation/screens/member_screen_homepage.dart';
import 'package:family_guard/features/member_management/presentation/widgets/member_list_screen.dart';
import 'package:family_guard/features/member_management/presentation/widgets/member_selection_screen.dart';
import 'package:family_guard/features/notification/presentation/screens/notification_screen.dart';
import 'package:family_guard/features/priority_contacts/presentation/screens/priority_contacts_screen.dart';
import 'package:family_guard/features/priority_contacts/presentation/widgets/add_priority_contact_screen.dart';
import 'package:family_guard/features/profile_security/presentation/screens/personal_info_screen.dart';
import 'package:family_guard/features/profile_security/presentation/widgets/password_security_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/screens/safe_zone_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/legacy_safe_zone_scope.dart';
import 'package:family_guard/features/settings/presentation/screens/settings_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_account_info_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_personal_info_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_security_screen.dart';
import 'package:family_guard/features/signup/presentation/widgets/signup_form_data.dart';
import 'package:family_guard/features/splash/presentation/screens/splash_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/family_map_screen.dart';
import 'package:family_guard/features/tracking/presentation/widgets/kid_management_screen.dart';
import 'package:family_guard/lib/core/routes/app_routes.dart' as legacy_routes;
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static Map<String, WidgetBuilder> get routes => {
    AppRoutes.splash: (context) => const FamilyGuardSplashScreen(),
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.tracking: (context) => const FamilyMapScreen(),
    AppRoutes.settings: (context) => const SettingsScreen(),
    AppRoutes.profile: (context) => const PersonalInfoScreen(),
    AppRoutes.passwordSecurity: (context) => const PasswordSecurityScreen(),
    AppRoutes.notifications: (context) => const NotificationScreen(),
    AppRoutes.memberManagement: (context) => const MemberManagementScreen(),
    AppRoutes.memberList: (context) => const ThanhVienScreen(),
    AppRoutes.memberDetails: (context) => const MemberScreen(),
    AppRoutes.addMember: (context) => const AddMemberScreen(),
    AppRoutes.memberSelection: (context) => const MemberSelectionScreen(),
    AppRoutes.safeZone: (context) => const SafeZoneScreen(),
    AppRoutes.priorityContacts: (context) => const PriorityContactsScreen(),
    AppRoutes.addPriorityContact: (context) => const AddPriorityContactScreen(),
    AppRoutes.checkinReminder: (context) => const CheckinReminderScreen(),
    AppRoutes.checkinReminderSelected: (context) => const CheckinReminderSelectedScreen(),
    AppRoutes.emotionPulse: (context) => const EmotionPulseScreen(),
    AppRoutes.emotionJournal: (context) => const EmotionJournalScreen(),
    AppRoutes.kidManagement: (context) => const KidManagementScreen(),
    AppRoutes.signup: (context) => const SignupPersonalInfoScreen(),
    AppRoutes.signupAccount: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final data = args is SignupFormData ? args : const SignupFormData();
      return SignupAccountInfoScreen(initialData: data);
    },
    AppRoutes.signupSecurity: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final data = args is SignupFormData ? args : const SignupFormData();
      return SignupSecurityScreen(initialData: data);
    },
    ..._legacyFeatureRoutes,
  };

  static Map<String, WidgetBuilder> get _legacyFeatureRoutes {
    const excludedRoutes = {
      legacy_routes.AppRoutes.home,
      legacy_routes.AppRoutes.login,
      legacy_routes.AppRoutes.mainShell,
      legacy_routes.AppRoutes.profile,
      legacy_routes.AppRoutes.memberList,
      legacy_routes.AppRoutes.settings,
    };

    const safeZoneRoutes = {
      legacy_routes.AppRoutes.safeZoneAlert,
      legacy_routes.AppRoutes.safeZoneManagement,
      legacy_routes.AppRoutes.safeZoneSelectMember,
      legacy_routes.AppRoutes.safeZoneEmpty,
      legacy_routes.AppRoutes.safeZoneAdd,
      legacy_routes.AppRoutes.safeZoneDetail,
      legacy_routes.AppRoutes.safeZoneTimeRules,
      legacy_routes.AppRoutes.safeZoneEdit,
      legacy_routes.AppRoutes.safeZoneDeleteConfirm,
      legacy_routes.AppRoutes.safeZoneAlertSettings,
      legacy_routes.AppRoutes.safeZoneInfo,
      legacy_routes.AppRoutes.safeZoneConfig,
      legacy_routes.AppRoutes.safeZoneActive,
      legacy_routes.AppRoutes.safeZoneEditActive,
    };

    return Map<String, WidgetBuilder>.fromEntries(
      legacy_routes.AppRoutes.routes.entries.where(
        (entry) => !excludedRoutes.contains(entry.key),
      ).map((entry) {
        if (!safeZoneRoutes.contains(entry.key)) {
          return entry;
        }

        return MapEntry<String, WidgetBuilder>(
          entry.key,
          (context) => LegacySafeZoneScope(
            child: entry.value(context),
          ),
        );
      }),
    );
  }
}
