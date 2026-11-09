import 'package:flutter/material.dart';

class FarmFormScreen extends StatefulWidget {
  const FarmFormScreen({super.key});

  @override
  State<FarmFormScreen> createState() => _FarmFormScreenState();
}

class _FarmFormScreenState extends State<FarmFormScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _areaController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Farm')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Farm name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Address'),
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
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Farm API is not implemented yet.')),
              );
            },
            child: const Text('Save farm'),
          ),
        ],
      ),
    );
  }
}
