import 'package:flutter/material.dart';

import '../../core/routing/app_router.dart';
import '../../shared/widgets/app_drawer.dart';

class FarmListScreen extends StatelessWidget {
  const FarmListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farm Management')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.farmForm),
        icon: const Icon(Icons.add),
        label: const Text('Add farm'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No farms loaded. Farm data will be fetched from the Node.js API '
            'once the backend endpoints are implemented.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
