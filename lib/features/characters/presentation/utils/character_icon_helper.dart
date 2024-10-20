import 'package:rick_and_morty_app/config/helpers/assets.dart';

import '../../domain/entities/character_model.dart';

class CharacterIconHelper {
  static String getSpeciesIcon(CharacterSpecies species) {
    switch (species) {
      case CharacterSpecies.alien:
        return AssetIconPath.speciesAlien24.path;
      case CharacterSpecies.human:
        return AssetIconPath.speciesHuman24.path;
      default:
        return AssetIconPath.speciesAlien24.path;
    }
  }

  static String getGenderIcon(CharacterGender gender) {
    switch (gender) {
      case CharacterGender.female:
        return AssetIconPath.genderFemale24.path;
      case CharacterGender.male:
        return AssetIconPath.genderMale24.path;;
      default:
        return AssetIconPath.genderUnknown24.path;
    }
  }

  static String getStatusIcon(CharacterStatus status) {
    switch (status) {
      case CharacterStatus.alive:
        return AssetIconPath.statusAlive24.path;
      case CharacterStatus.dead:
        return AssetIconPath.statusDead24.path;
      default:
        return AssetIconPath.statusUnknown24.path;
    }
  }

}
