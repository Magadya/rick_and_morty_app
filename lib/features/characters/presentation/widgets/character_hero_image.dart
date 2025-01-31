import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/domain/entities/character_model.dart';
import 'package:rick_and_morty_app/features/common/presentation/widgets/gridient_overlay.dart';

class CharacterHeroImage extends StatelessWidget {
  final CharacterModel character;

  const CharacterHeroImage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'character_image_${character.id}',
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(character.image, fit: BoxFit.cover),
          const GradientOverlay(),
        ],
      ),
    );
  }
}