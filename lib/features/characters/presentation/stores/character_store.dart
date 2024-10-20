import 'package:mobx/mobx.dart';
import '../../domain/entities/character_model.dart';
import '../../domain/usecases/get_characters.dart';

part 'character_store.g.dart';

class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store {
  final GetCharacters getCharacters;
  final ToggleCharacterLike toggleCharacterLike;

  _CharacterStore({
    required this.getCharacters,
    required this.toggleCharacterLike,
  });

  @observable
  ObservableList<CharacterModel> characters = ObservableList<CharacterModel>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> loadCharacters() async {
    isLoading = true;
    error = null;

    try {
      final result = await getCharacters();
      result.fold(
            (failure) => error = failure.message,
            (charactersList) => characters = ObservableList.of(charactersList),
      );
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleLike(int characterId) async {
    final result = await toggleCharacterLike(characterId);
    result.fold(
          (failure) => error = failure.message,
          (_) {
        final index = characters.indexWhere((c) => c.id == characterId);
        if (index != -1) {
          final character = characters[index];
          characters[index] = character.copyWith(isLiked: !character.isLiked);
        }
      },
    );
  }
}