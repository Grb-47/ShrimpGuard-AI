import 'package:flutter/material.dart';

class FeaturePlaceholder extends StatelessWidget {
  const FeaturePlaceholder({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.plannedItems = const [],
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> plannedItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Icon(icon, size: 56, color: theme.colorScheme.primary),
        const SizedBox(height: 16),
        Text(title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(description, style: theme.textTheme.bodyMedium),
        if (plannedItems.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text('Planned in this module', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          ...plannedItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'This is a Week 02 foundation screen. Business logic will be '
              'implemented in a later phase.',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
