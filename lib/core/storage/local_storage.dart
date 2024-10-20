import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  static const String _likedCharactersKey = 'liked_characters';

  Future<Set<int>> getLikedCharacters() async {
    final likedCharacters = _prefs.getStringList(_likedCharactersKey) ?? [];
    return likedCharacters.map((id) => int.parse(id)).toSet();
  }

  Future<void> toggleCharacterLike(int characterId) async {
    final likedCharacters = await getLikedCharacters();

    if (likedCharacters.contains(characterId)) {
      likedCharacters.remove(characterId);
    } else {
      likedCharacters.add(characterId);
    }

    await _prefs.setStringList(
      _likedCharactersKey,
      likedCharacters.map((id) => id.toString()).toList(),
    );
  }
}