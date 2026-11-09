import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/feature_placeholder.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historical Data')),
      drawer: const AppDrawer(),
      body: const FeaturePlaceholder(
        icon: Icons.history,
        title: 'Historical Data',
        description:
            'Browse sensor and manual test history for each farm and pond.',
        plannedItems: [
          'Filter by pond, parameter, and date range',
          'Separate sensor readings from manual tests',
          'Show reading quality flags',
          'Export later for reporting',
        ],
      ),
    );
  }
}
