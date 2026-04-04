import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/features/chat/presentation/screens/chat_conversation_screen.dart';
import 'package:family_guard/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:family_guard/features/checkin_reminder/presentation/screens/checkin_reminder_screen.dart';
import 'package:family_guard/features/checkin_reminder/presentation/widgets/checkin_reminder_selected_screen.dart';
import 'package:family_guard/features/emotion/presentation/screens/emotion_pulse_screen.dart';
import 'package:family_guard/features/emotion/presentation/widgets/emotion_journal_screen.dart';
import 'package:family_guard/features/home/presentation/screens/homepage.dart';
import 'package:family_guard/features/login/presentation/screens/forgot_password_screen.dart';
import 'package:family_guard/features/login/presentation/screens/login_screen.dart';
import 'package:family_guard/features/member_management/presentation/screens/member_management_screen.dart';
import 'package:family_guard/features/member_management/presentation/widgets/add_member_screen.dart';
import 'package:family_guard/features/member_management/presentation/widgets/member_list_screen.dart';
import 'package:family_guard/features/member_management/presentation/screens/member_screen_homepage.dart';
import 'package:family_guard/features/member_management/presentation/widgets/member_selection_screen.dart';
import 'package:family_guard/features/notification/presentation/screens/notification_screen.dart';
import 'package:family_guard/features/priority_contacts/presentation/screens/priority_contacts_screen.dart';
import 'package:family_guard/features/priority_contacts/presentation/widgets/add_priority_contact_screen.dart';
import 'package:family_guard/features/profile_security/presentation/screens/personal_info_screen.dart';
import 'package:family_guard/features/profile_security/presentation/widgets/password_security_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/screens/safe_zone_screen.dart';
import 'package:family_guard/features/settings/presentation/screens/settings_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_account_info_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_personal_info_screen.dart';
import 'package:family_guard/features/signup/presentation/screens/signup_security_screen.dart';
import 'package:family_guard/features/signup/presentation/widgets/signup_form_data.dart';
import 'package:family_guard/features/splash/presentation/screens/splash_screen.dart';
import 'package:family_guard/features/calling/presentation/screens/in_app_call_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/family_map_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/adult_member_detail_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/child_member_detail_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/route_playback_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/senior_member_detail_screen.dart';
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
    AppRoutes.checkinReminderSelected: (context) =>
        const CheckinReminderSelectedScreen(),
    AppRoutes.emotionPulse: (context) => const EmotionPulseScreen(),
    AppRoutes.emotionJournal: (context) => const EmotionJournalScreen(),
    AppRoutes.kidManagement: (context) => const ChildMemberDetailScreen(),
    AppRoutes.adultMemberDetail: (context) => AdultMemberDetailScreen(
      args: AdultMemberDetailScreen.fromRoute(context),
    ),
    AppRoutes.seniorMemberDetail: (context) => SeniorMemberDetailScreen(
      args: SeniorMemberDetailScreen.fromRoute(context),
    ),
    AppRoutes.routePlayback: (context) =>
        RoutePlaybackScreen(args: RoutePlaybackScreen.fromRoute(context)),
    AppRoutes.inAppCall: (context) =>
        InAppCallScreen(args: InAppCallScreen.fromRoute(context)),
    AppRoutes.chatList: (context) => const ChatListScreen(),
    AppRoutes.chatConversation: (context) => ChatConversationScreen(
      thread: ChatConversationScreen.fromRoute(context),
    ),
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
}
