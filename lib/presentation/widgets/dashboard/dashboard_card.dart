// Dashboard card widget
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  const DashboardCard({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(title)));
  }
}
