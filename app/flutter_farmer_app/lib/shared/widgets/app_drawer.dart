import 'package:flutter/material.dart';

import '../../core/routing/app_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF00796B)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.water_drop, color: Colors.white, size: 36),
                  SizedBox(height: 8),
                  Text(
                    'ShrimpGuard AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _item(context, Icons.dashboard, 'Dashboard', AppRoutes.dashboard),
            _item(context, Icons.agriculture, 'Farms', AppRoutes.farms),
            _item(context, Icons.water, 'Ponds', AppRoutes.ponds),
            _item(context, Icons.bluetooth, 'Devices', AppRoutes.devices),
            _item(context, Icons.science, 'Water Testing', AppRoutes.waterTesting),
            _item(context, Icons.biotech, 'Manual Ammonia', AppRoutes.manualAmmonia),
            _item(context, Icons.psychology, 'AI Risk Analysis', AppRoutes.riskAnalysis),
            _item(context, Icons.translate, 'Bengali Recommendations', AppRoutes.recommendations),
            _item(context, Icons.history, 'History', AppRoutes.history),
            _item(context, Icons.show_chart, 'Charts', AppRoutes.charts),
            _item(context, Icons.notifications, 'Notifications', AppRoutes.notifications),
            _item(context, Icons.person, 'Farmer Profile', AppRoutes.profile),
            _item(context, Icons.settings, 'Settings', AppRoutes.settings),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
