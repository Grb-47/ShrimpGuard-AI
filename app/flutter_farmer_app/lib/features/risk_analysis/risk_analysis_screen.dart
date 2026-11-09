import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/feature_placeholder.dart';

class RiskAnalysisScreen extends StatelessWidget {
  const RiskAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Risk Analysis')),
      drawer: const AppDrawer(),
      body: const FeaturePlaceholder(
        icon: Icons.psychology,
        title: 'AI Risk Analysis',
        description:
            'Request a risk report for a pond. Expert-validated rules and '
            'historical trends classify risk before Gemini explains it in Bengali.',
        plannedItems: [
          'Select a pond and analysis window',
          'Show risk level and contributing factors',
          'Display rule and trend evidence',
          'Load the Bengali recommendation text',
        ],
      ),
    );
  }
}
