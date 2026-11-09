import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';

class ManualAmmoniaScreen extends StatefulWidget {
  const ManualAmmoniaScreen({super.key});

  @override
  State<ManualAmmoniaScreen> createState() => _ManualAmmoniaScreenState();
}

class _ManualAmmoniaScreenState extends State<ManualAmmoniaScreen> {
  final _valueController = TextEditingController();
  final _kitController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    _kitController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual Ammonia Entry')),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Enter the result of the manual ammonia test kit for a pond.',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Ammonia value',
              helperText: 'Unit and kit range are To Be Confirmed',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _kitController,
            decoration: const InputDecoration(
              labelText: 'Test kit name',
              helperText: 'Kit brand is To Be Confirmed',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Notes'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Manual reading API is not implemented yet.'),
                ),
              );
            },
            child: const Text('Save reading'),
          ),
        ],
      ),
    );
  }
}
