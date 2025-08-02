// Clothing grid widget
import 'package:flutter/material.dart';

class ClothingGrid extends StatelessWidget {
  final List<String> items;
  const ClothingGrid({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: items.map((e) => ClothingCard(name: e)).toList(),
    );
  }
}
