// Stats widget
import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final String stats;
  const StatsWidget({required this.stats, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(stats)));
  }
}
