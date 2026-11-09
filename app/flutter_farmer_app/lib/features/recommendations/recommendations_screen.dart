import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/feature_placeholder.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bengali Recommendations')),
      drawer: const AppDrawer(),
      body: const FeaturePlaceholder(
        icon: Icons.translate,
        title: 'Bengali Recommendations',
        description:
            'Farmer-friendly Bengali explanations generated from a validated '
            'risk report. AI text never replaces the risk decision.',
        plannedItems: [
          'Plain-language Bengali explanation',
          'Priority and category for each recommendation',
          'Link back to the source risk report',
          'Offline access to recent recommendations',
        ],
      ),
    );
  }
}
