import 'package:dartz/dartz.dart';
import '../../../../core/storage/failure.dart';
import '../../domain/entities/character_model.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_local_datasource.dart';
import '../datasources/character_remote_datasource.dart';


class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<CharacterModel>>> getCharacters() async {
    try {
      final characters = await remoteDataSource.getCharacters();
      final likedIds = await localDataSource.getLikedCharacterIds();

      final charactersList = characters.map((char) {
        return char.copyWith(isLiked: likedIds.contains(char.id));
      }).toList();

      return Right(charactersList);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CharacterModel>> getCharacterById(int id) async {
    try {
      final character = await remoteDataSource.getCharacterById(id);
      final likedIds = await localDataSource.getLikedCharacterIds();
      return Right(character.copyWith(isLiked: likedIds.contains(character.id)));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleCharacterLike(int id) async {
    try {
      await localDataSource.toggleCharacterLike(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getLikedCharacterIds() async {
    try {
      final ids = await localDataSource.getLikedCharacterIds();
      return Right(ids);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CharacterModel>> getCharacterDetails(int id) async {
    try {
      // Use the existing getCharacterById method from remote data source
      final character = await remoteDataSource.getCharacterById(id);

      // Get liked status from local storage
      final likedIds = await localDataSource.getLikedCharacterIds();

      // Combine remote data with local liked status
      final characterWithLikeStatus = character.copyWith(
          isLiked: likedIds.contains(character.id)
      );

      return Right(characterWithLikeStatus);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

}