import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/feature_placeholder.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Charts')),
      drawer: const AppDrawer(),
      body: const FeaturePlaceholder(
        icon: Icons.show_chart,
        title: 'Charts',
        description:
            'Visualize water-quality trends over time for each pond.',
        plannedItems: [
          'Line chart per parameter',
          'Highlight risk thresholds',
          'Compare ponds within a farm',
          'Chart library selection is To Be Confirmed',
        ],
      ),
    );
  }
}
