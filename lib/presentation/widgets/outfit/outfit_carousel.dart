import 'package:flutter/material.dart';
import 'outfit_card.dart';

class OutfitCarousel extends StatelessWidget {
  final List<String> outfits;
  const OutfitCarousel({required this.outfits, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: outfits.length,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 16),
            child: OutfitCard(description: outfits[index]),
          );
        },
      ),
    );
  }
}
