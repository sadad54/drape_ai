import 'package:flutter/material.dart';
import '../clothing/clothing_card.dart';

class ClothingGrid extends StatelessWidget {
  final List<String> items;
  const ClothingGrid({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: items.map((item) => ClothingCard(name: item)).toList(),
    );
  }
}
