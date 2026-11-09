import 'package:flutter/material.dart';

class PondFormScreen extends StatefulWidget {
  const PondFormScreen({super.key});

  @override
  State<PondFormScreen> createState() => _PondFormScreenState();
}

class _PondFormScreenState extends State<PondFormScreen> {
  final _nameController = TextEditingController();
  final _areaController = TextEditingController();
  final _depthController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _depthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Pond')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Farm selection will be connected to the farm list.'),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Pond name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _areaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Area',
              helperText: 'Area unit is To Be Confirmed',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _depthController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Depth',
              helperText: 'Depth unit is To Be Confirmed',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pond API is not implemented yet.')),
              );
            },
            child: const Text('Save pond'),
          ),
        ],
      ),
    );
  }
}
