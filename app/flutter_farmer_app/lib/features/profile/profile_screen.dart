import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farmer Profile')),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CircleAvatar(radius: 44, child: Icon(Icons.person, size: 44)),
          SizedBox(height: 16),
          Center(child: Text('Farmer profile')),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Name, phone, location, and account settings will appear here.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
