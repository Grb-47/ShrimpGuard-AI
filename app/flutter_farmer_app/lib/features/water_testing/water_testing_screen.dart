import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/feature_placeholder.dart';

class WaterTestingScreen extends StatelessWidget {
  const WaterTestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water Testing')),
      drawer: const AppDrawer(),
      body: const FeaturePlaceholder(
        icon: Icons.science,
        title: 'Water Testing',
        description:
            'Review pH, dissolved oxygen, temperature, and salinity readings '
            'received from the ESP32.',
        plannedItems: [
          'Latest reading per sensor',
          'Manual refresh after Bluetooth sync',
          'Reading quality and device status',
          'Submit readings to the Node.js API',
        ],
      ),
    );
  }
}
