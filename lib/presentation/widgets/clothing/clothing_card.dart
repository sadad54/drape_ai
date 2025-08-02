// Clothing card widget
import 'package:flutter/material.dart';

class ClothingCard extends StatelessWidget {
  final String name;
  const ClothingCard({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(name)));
  }
}
