// Outfit card widget
import 'package:flutter/material.dart';

class OutfitCard extends StatelessWidget {
  final String description;
  const OutfitCard({required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(description)));
  }
}
