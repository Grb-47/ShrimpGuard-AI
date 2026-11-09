import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/feature_placeholder.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const AppDrawer(),
      body: const FeaturePlaceholder(
        icon: Icons.settings,
        title: 'Settings',
        description:
            'Application preferences, language, device behavior, and account '
            'options.',
        plannedItems: [
          'Bengali and English language preference',
          'Notification preferences',
          'API server configuration for development',
          'Account and sign-out actions',
        ],
      ),
    );
  }
}
