import 'package:rick_and_morty_app/core/api/api_client.dart';
import 'package:rick_and_morty_app/core/error/data_source_exception.dart';
import 'package:rick_and_morty_app/features/characters/domain/entities/character_model.dart';

class CharacterRemoteDataSource {
  final ApiClient _apiClient;

  CharacterRemoteDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<CharacterModel>> getCharacters({int page = 1}) async {
    final result = await _apiClient.get<Map<String, dynamic>>(
      '/character',
      queryParameters: {'page': page},
    );

    if (!result.isSuccess || result.data == null) {
      throw DataSourceException(message: result.error ?? 'Failed to fetch characters');
    }

    final results = result.data!['results'] as List;
    return results.map((character) => CharacterModel.fromJson(character)).toList();
  }

  Future<CharacterModel> getCharacterById(int id) async {
    final result = await _apiClient.get<Map<String, dynamic>>('/character/$id');

    if (!result.isSuccess || result.data == null) {
      throw DataSourceException(message: result.error ?? 'Failed to fetch character');
    }

    return CharacterModel.fromJson(result.data!);
  }

  Future<List<CharacterModel>> searchCharacters(String query) async {
    return _getCharactersWithParams({'name': query});
  }

  Future<List<CharacterModel>> getCharactersByStatus(String status) async {
    return _getCharactersWithParams({'status': status});
  }

  Future<List<CharacterModel>> _getCharactersWithParams(Map<String, dynamic> params) async {
    final result = await _apiClient.get<Map<String, dynamic>>(
      '/character',
      queryParameters: params,
    );

    if (!result.isSuccess || result.data == null) {
      throw DataSourceException(message: result.error ?? 'Failed to fetch characters');
    }

    final results = result.data!['results'] as List;
    return results.map((character) => CharacterModel.fromJson(character)).toList();
  }
}