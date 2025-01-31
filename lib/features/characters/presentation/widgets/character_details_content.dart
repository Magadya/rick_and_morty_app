import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/domain/entities/character_model.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/character_app_bar.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/character_info_list.dart';

class CharacterDetailsContent extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailsContent({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CharacterAppBar(character: character),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CharacterInfoList(character: character),
          ),
        ),
      ],
    );
  }
}
