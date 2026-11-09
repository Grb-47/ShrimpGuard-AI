import 'package:flutter/material.dart';

import '../../core/routing/app_router.dart';
import '../../shared/widgets/app_drawer.dart';

class PondListScreen extends StatelessWidget {
  const PondListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pond Management')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.pondForm),
        icon: const Icon(Icons.add),
        label: const Text('Add pond'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No ponds loaded. Ponds will be linked to farms after the backend '
            'endpoints are implemented.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
