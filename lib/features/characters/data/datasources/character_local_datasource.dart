
import 'package:shared_preferences/shared_preferences.dart';

abstract class CharacterLocalDataSource {
  Future<List<int>> getLikedCharacterIds();
  Future<void> toggleCharacterLike(int id);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String likedCharactersKey = 'liked_characters';

  CharacterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<int>> getLikedCharacterIds() async {
    final likedIds = sharedPreferences.getStringList(likedCharactersKey);
    return likedIds?.map((id) => int.parse(id)).toList() ?? [];
  }

  @override
  Future<void> toggleCharacterLike(int id) async {
    final likedIds = await getLikedCharacterIds();
    if (likedIds.contains(id)) {
      likedIds.remove(id);
    } else {
      likedIds.add(id);
    }
    await sharedPreferences.setStringList(
      likedCharactersKey,
      likedIds.map((id) => id.toString()).toList(),
    );
  }
}
