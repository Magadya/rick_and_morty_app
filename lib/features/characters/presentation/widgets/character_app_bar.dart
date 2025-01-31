import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/domain/entities/character_model.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/character_hero_image.dart';
import 'package:rick_and_morty_app/features/common/presentation/widgets/back_button_circle.dart';

class CharacterAppBar extends StatelessWidget {
  final CharacterModel character;

  const CharacterAppBar({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 4,
      pinned: true,
      leading: const BackButtonCircle(),
      flexibleSpace: FlexibleSpaceBar(
        background: CharacterHeroImage(character: character),
      ),
    );
  }
}