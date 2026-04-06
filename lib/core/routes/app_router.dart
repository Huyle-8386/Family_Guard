import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/features/checkin_reminder/presentation/screens/checkin_reminder_screen.dart';
import 'package:family_guard/features/checkin_reminder/presentation/widgets/checkin_reminder_selected_screen.dart';
import 'package:family_guard/features/emotion/presentation/screens/emotion_pulse_screen.dart';
import 'package:family_guard/features/emotion/presentation/widgets/emotion_journal_screen.dart';
import 'package:family_guard/features/home/presentation/screens/homepage.dart';
import 'package:family_guard/features/login/presentation/screens/forgot_password_screen.dart';
import 'package:family_guard/features/login/presentation/screens/login_screen.dart';
import 'package:family_guard/features/medical/presentation/screens/medical_appointment_screen.dart';
import 'package:family_guard/features/member_management/presentation/screens/member_management_screen.dart';
import 'package:family_guard/features/member_management/presentation/widgets/add_member_screen.dart';
import 'package:family_guard/features/member_management/presentation/screens/member_screen_homepage.dart';
import 'package:family_guard/features/member_management/presentation/widgets/member_list_screen.dart';
import 'package:family_guard/features/member_management/presentation/widgets/member_selection_screen.dart';
import 'package:family_guard/features/notification/presentation/screens/notification_screen.dart';
import 'package:family_guard/features/physical/presentation/screens/physical_activity_screen.dart';
import 'package:family_guard/features/priority_contacts/presentation/screens/priority_contacts_screen.dart';
import 'package:family_guard/features/priority_contacts/presentation/widgets/add_priority_contact_screen.dart';
import 'package:family_guard/features/profile_security/presentation/screens/personal_info_screen.dart';
import 'package:family_guard/features/profile_security/presentation/widgets/password_security_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/create_reminder_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/notification_preview_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/reminder_detail_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/reminder_details_view_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/reminder_list_delete_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/reminder_list_editable_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/reminder_list_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/repeat_frequency_screen.dart';
import 'package:family_guard/features/reminder/presentation/widgets/voice_recording_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/screens/safe_zone_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/legacy_safe_zone_scope.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_active_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_add_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_alert_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_alert_settings_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_config_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_delete_confirm_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_detail_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_edit_active_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_edit_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_empty_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_info_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_select_member_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_time_rules_screen.dart';
import 'package:family_guard/features/settings/presentation/screens/settings_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_account_info_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_personal_info_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_security_screen.dart';
import 'package:family_guard/features/signup/presentation/widgets/signup_form_data.dart';
import 'package:family_guard/features/splash/presentation/screens/splash_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/activity_history_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/family_map_screen.dart';
import 'package:family_guard/features/tracking/presentation/widgets/activity_report_screen.dart';
import 'package:family_guard/features/tracking/presentation/widgets/history_statistics_screen.dart';
import 'package:family_guard/features/tracking/presentation/widgets/kid_management_screen.dart';
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
    AppRoutes.safeZoneAlert: (context) => _safeZoneRoute(const SafeZoneAlertScreen()),
    AppRoutes.safeZoneSelectMember: (context) =>
        _safeZoneRoute(const SafeZoneSelectMemberScreen()),
    AppRoutes.safeZoneEmpty: (context) => _safeZoneRoute(const SafeZoneEmptyScreen()),
    AppRoutes.safeZoneAdd: (context) => _safeZoneRoute(const SafeZoneAddScreen()),
    AppRoutes.safeZoneDetail: (context) => _safeZoneRoute(const SafeZoneDetailScreen()),
    AppRoutes.safeZoneTimeRules: (context) =>
        _safeZoneRoute(const SafeZoneTimeRulesScreen()),
    AppRoutes.safeZoneEdit: (context) => _safeZoneRoute(const SafeZoneEditScreen()),
    AppRoutes.safeZoneDeleteConfirm: (context) =>
        _safeZoneRoute(const SafeZoneDeleteConfirmScreen()),
    AppRoutes.safeZoneAlertSettings: (context) =>
        _safeZoneRoute(const SafeZoneAlertSettingsScreen()),
    AppRoutes.safeZoneInfo: (context) => _safeZoneRoute(const SafeZoneInfoScreen()),
    AppRoutes.safeZoneConfig: (context) => _safeZoneRoute(const SafeZoneConfigScreen()),
    AppRoutes.safeZoneActive: (context) => _safeZoneRoute(const SafeZoneMemberScreen()),
    AppRoutes.safeZoneEditActive: (context) =>
        _safeZoneRoute(const SafeZoneEditActiveScreen()),
    AppRoutes.priorityContacts: (context) => const PriorityContactsScreen(),
    AppRoutes.addPriorityContact: (context) => const AddPriorityContactScreen(),
    AppRoutes.checkinReminder: (context) => const CheckinReminderScreen(),
    AppRoutes.checkinReminderSelected: (context) => const CheckinReminderSelectedScreen(),
    AppRoutes.reminderList: (context) => const ReminderListScreen(),
    AppRoutes.reminderListEditable: (context) =>
        const ReminderListEditableScreen(),
    AppRoutes.reminderListDelete: (context) => const ReminderListDeleteScreen(),
    AppRoutes.reminderDetail: (context) => const ReminderDetailScreen(),
    AppRoutes.reminderDetailsView: (context) =>
        const ReminderDetailsViewScreen(),
    AppRoutes.notificationPreview: (context) =>
        const NotificationPreviewScreen(),
    AppRoutes.createReminder: (context) => const CreateReminderScreen(),
    AppRoutes.repeatFrequency: (context) => const RepeatFrequencyScreen(),
    AppRoutes.voiceRecording: (context) => const VoiceRecordingScreen(),
    AppRoutes.historyStatistics: (context) =>
        const HistoryStatisticsScreen(),
    AppRoutes.activityReport: (context) => const ActivityReportScreen(),
    AppRoutes.activityHistory: (context) => const ActivityHistoryScreen(),
    AppRoutes.medicalAppointment: (context) =>
        const MedicalAppointmentScreen(),
    AppRoutes.physicalActivity: (context) => const PhysicalActivityScreen(),
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
  };

  static Widget _safeZoneRoute(Widget child) => LegacySafeZoneScope(child: child);
}
