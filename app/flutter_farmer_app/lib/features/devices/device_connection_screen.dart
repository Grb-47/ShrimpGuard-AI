import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';

class DeviceConnectionScreen extends StatelessWidget {
  const DeviceConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Connection')),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.bluetooth, size: 56),
          const SizedBox(height: 12),
          const Text(
            'Connect the ESP32 over Bluetooth to receive water-quality readings.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Bluetooth profile and payload format are To Be Confirmed.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search),
            label: const Text('Scan for ESP32 devices'),
          ),
          const SizedBox(height: 24),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('No device connected'),
              subtitle: Text(
                'Device pairing will be implemented after the hardware '
                'protocol is finalized.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
