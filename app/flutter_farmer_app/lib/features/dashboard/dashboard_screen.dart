import 'package:flutter/material.dart';

import '../../core/routing/app_router.dart';
import '../../shared/widgets/app_drawer.dart';

class _QuickAction {
  const _QuickAction(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _actions = [
    _QuickAction('Farms', Icons.agriculture, AppRoutes.farms),
    _QuickAction('Ponds', Icons.water, AppRoutes.ponds),
    _QuickAction('Devices', Icons.bluetooth, AppRoutes.devices),
    _QuickAction('Water Test', Icons.science, AppRoutes.waterTesting),
    _QuickAction('Ammonia', Icons.biotech, AppRoutes.manualAmmonia),
    _QuickAction('Risk Analysis', Icons.psychology, AppRoutes.riskAnalysis),
    _QuickAction('Charts', Icons.show_chart, AppRoutes.charts),
    _QuickAction('Alerts', Icons.notifications, AppRoutes.notifications),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to ShrimpGuard AI', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Connect a device, record water tests, and review risk '
                    'reports for each pond.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Quick actions', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              for (final action in _actions)
                Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.pushNamed(context, action.route),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(action.icon, color: theme.colorScheme.primary, size: 30),
                        const SizedBox(height: 8),
                        Text(action.label, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Foundation status', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Text('Live sensor data and AI analysis will be connected '
                      'after the backend and hardware protocol are finalized.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
