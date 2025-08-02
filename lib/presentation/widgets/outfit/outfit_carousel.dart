// Outfit carousel widget
import 'package:flutter/material.dart';

class OutfitCarousel extends StatelessWidget {
  final List<String> outfits;
  const OutfitCarousel({required this.outfits, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: outfits.map((e) => OutfitCard(description: e)).toList(),
    );
  }
}
