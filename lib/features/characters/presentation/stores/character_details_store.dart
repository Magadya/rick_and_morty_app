import 'package:mobx/mobx.dart';
import '../../domain/entities/character_model.dart';
import '../../domain/usecases/get_characters.dart';


part 'character_details_store.g.dart';

class CharacterDetailsStore = _CharacterDetailsStore with _$CharacterDetailsStore;

abstract class _CharacterDetailsStore with Store {
  final GetCharacterDetails getCharacterDetails;
  final ToggleCharacterLike toggleCharacterLike;

  _CharacterDetailsStore({
    required this.getCharacterDetails,
    required this.toggleCharacterLike,
  });

  @observable
  CharacterModel? character;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> loadCharacterDetails(int characterId) async {
    isLoading = true;
    error = null;

    try {
      final result = await getCharacterDetails(characterId);
      result.fold(
            (failure) => error = failure.message,
            (characterData) => character = characterData,
      );
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleLike(int characterId) async {
    if (character == null) return;

    final result = await toggleCharacterLike(characterId);
    result.fold(
          (failure) => error = failure.message,
          (_) {
        character = character!.copyWith(isLiked: !character!.isLiked);
      },
    );
  }
}