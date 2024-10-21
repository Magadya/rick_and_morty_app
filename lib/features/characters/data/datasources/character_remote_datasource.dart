import '../../../../core/api/api_client.dart';
import '../../domain/entities/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters({int page = 1});

  Future<CharacterModel> getCharacterById(int id);

  Future<List<CharacterModel>> searchCharacters(String query);

  Future<List<CharacterModel>> getCharactersByStatus(String status);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final ApiClient apiClient;

  CharacterRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<CharacterModel>> getCharacters({int page = 1}) async {
    try {
      final result = await apiClient.get<Map<String, dynamic>>(
        '/character',
        queryParameters: {'page': page},
      );

      if (result.isSuccess && result.data != null) {
        final results = result.data!['results'];

        if (results is List) {
          return results.map((character) => CharacterModel.fromJson(character as Map<String, dynamic>)).toList();
        } else {
          throw DataSourceException(
            message: 'Unexpected data format: results is not a list',
          );
        }
      } else {
        throw DataSourceException(
          message: result.error ?? 'Failed to fetch characters',
        );
      }
    } catch (e) {
      throw DataSourceException(
        message: 'An error occurred while fetching characters',
        error: e,
      );
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final result = await apiClient.get<Map<String, dynamic>>('/character/$id');

      if (result.isSuccess && result.data != null) {
        return CharacterModel.fromJson(result.data!);
      } else {
        throw DataSourceException(
          message: result.error ?? 'Failed to fetch character details',
        );
      }
    } catch (e) {
      throw DataSourceException(
        message: 'An error occurred while fetching character details',
        error: e,
      );
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    try {
      final result = await apiClient.get<Map<String, dynamic>>(
        '/character',
        queryParameters: {'name': query},
      );

      if (result.isSuccess && result.data != null) {
        final results = result.data!['results'] as List;
        return results.map((character) => CharacterModel.fromJson(character)).toList();
      } else {
        throw DataSourceException(
          message: result.error ?? 'Failed to search characters',
        );
      }
    } catch (e) {
      throw DataSourceException(
        message: 'An error occurred while searching characters',
        error: e,
      );
    }
  }

  @override
  Future<List<CharacterModel>> getCharactersByStatus(String status) async {
    try {
      final result = await apiClient.get<Map<String, dynamic>>(
        '/character',
        queryParameters: {'status': status},
      );

      if (result.isSuccess && result.data != null) {
        final results = result.data!['results'] as List;
        return results.map((character) => CharacterModel.fromJson(character)).toList();
      } else {
        throw DataSourceException(
          message: result.error ?? 'Failed to fetch characters by status',
        );
      }
    } catch (e) {
      throw DataSourceException(
        message: 'An error occurred while fetching characters by status',
        error: e,
      );
    }
  }
}

class DataSourceException implements Exception {
  final String message;
  final dynamic error;

  DataSourceException({
    required this.message,
    this.error,
  });

  @override
  String toString() => 'DataSourceException: $message${error != null ? ' (Error: $error)' : ''}';
}
