import 'package:flutter/material.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/charts/charts_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/devices/device_connection_screen.dart';
import '../../features/farms/farm_form_screen.dart';
import '../../features/farms/farm_list_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/manual_ammonia/manual_ammonia_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/ponds/pond_form_screen.dart';
import '../../features/ponds/pond_list_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/recommendations/recommendations_screen.dart';
import '../../features/risk_analysis/risk_analysis_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/water_testing/water_testing_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String farms = '/farms';
  static const String farmForm = '/farms/new';
  static const String ponds = '/ponds';
  static const String pondForm = '/ponds/new';
  static const String devices = '/devices';
  static const String waterTesting = '/water-testing';
  static const String manualAmmonia = '/manual-ammonia';
  static const String riskAnalysis = '/risk-analysis';
  static const String recommendations = '/recommendations';
  static const String history = '/history';
  static const String charts = '/charts';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
}

class AppRouter {
  AppRouter._();

  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.login: (_) => const LoginScreen(),
      AppRoutes.register: (_) => const RegisterScreen(),
      AppRoutes.dashboard: (_) => const DashboardScreen(),
      AppRoutes.profile: (_) => const ProfileScreen(),
      AppRoutes.farms: (_) => const FarmListScreen(),
      AppRoutes.farmForm: (_) => const FarmFormScreen(),
      AppRoutes.ponds: (_) => const PondListScreen(),
      AppRoutes.pondForm: (_) => const PondFormScreen(),
      AppRoutes.devices: (_) => const DeviceConnectionScreen(),
      AppRoutes.waterTesting: (_) => const WaterTestingScreen(),
      AppRoutes.manualAmmonia: (_) => const ManualAmmoniaScreen(),
      AppRoutes.riskAnalysis: (_) => const RiskAnalysisScreen(),
      AppRoutes.recommendations: (_) => const RecommendationsScreen(),
      AppRoutes.history: (_) => const HistoryScreen(),
      AppRoutes.charts: (_) => const ChartsScreen(),
      AppRoutes.notifications: (_) => const NotificationsScreen(),
      AppRoutes.settings: (_) => const SettingsScreen(),
    };
  }
}
