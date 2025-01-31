import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/helpers/assets.dart';
import 'package:rick_and_morty_app/core/extentsions/string.dart';
import 'package:rick_and_morty_app/features/characters/domain/entities/character_model.dart';
import 'package:rick_and_morty_app/features/characters/presentation/utils/character_icon_helper.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/charcter_info_row.dart';

class CharacterInfoList extends StatelessWidget {
  final CharacterModel character;

  const CharacterInfoList({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final speciesIcon = CharacterIconHelper.getSpeciesIcon(character.species);
    final genderIcon = CharacterIconHelper.getGenderIcon(character.gender);
    final statusIcon = CharacterIconHelper.getStatusIcon(character.status);

    return Column(
      children: [
        CharacterInfoRow(
          iconPath: AssetIconPath.info24.path,
          label: 'Name',
          value: character.name.capitalize(),
        ),
        CharacterInfoRow(
          iconPath: statusIcon,
          label: 'Status',
          value: character.status.name.capitalize(),
        ),
        CharacterInfoRow(
          iconPath: speciesIcon,
          label: 'Species',
          value: character.species.name.capitalize(),
        ),
        CharacterInfoRow(
          iconPath: genderIcon,
          label: 'Gender',
          value: character.gender.name.capitalize(),
        ),
      ],
    );
  }
}