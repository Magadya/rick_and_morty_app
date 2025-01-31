import 'package:shared_preferences/shared_preferences.dart';

class CharacterLocalDataSource {
  final SharedPreferences _prefs;
  static const String _likedCharactersKey = 'liked_characters';

  CharacterLocalDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  Future<List<int>> getLikedCharacterIds() async {
    final likedIds = _prefs.getStringList(_likedCharactersKey);
    return likedIds?.map((id) => int.parse(id)).toList() ?? [];
  }

  Future<void> toggleCharacterLike(int id) async {
    final likedIds = await getLikedCharacterIds();
    if (likedIds.contains(id)) {
      likedIds.remove(id);
    } else {
      likedIds.add(id);
    }
    await _prefs.setStringList(
      _likedCharactersKey,
      likedIds.map((id) => id.toString()).toList(),
    );
  }
}
