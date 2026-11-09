import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/feature_placeholder.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      drawer: const AppDrawer(),
      body: const FeaturePlaceholder(
        icon: Icons.notifications,
        title: 'Notifications',
        description:
            'Alerts for risky pond conditions, device issues, and calibration '
            'reminders.',
        plannedItems: [
          'In-app notification list',
          'Read and unread states',
          'Pond and risk report links',
          'Push and SMS delivery are future work',
        ],
      ),
    );
  }
}
