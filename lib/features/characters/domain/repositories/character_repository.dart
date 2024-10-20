
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/storage/failure.dart';

import '../entities/character_model.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterModel>>> getCharacters();
  Future<Either<Failure, CharacterModel>> getCharacterById(int id);
  Future<Either<Failure, void>> toggleCharacterLike(int id);
  Future<Either<Failure, List<int>>> getLikedCharacterIds();
  Future<Either<Failure, CharacterModel>> getCharacterDetails(int characterId);
}