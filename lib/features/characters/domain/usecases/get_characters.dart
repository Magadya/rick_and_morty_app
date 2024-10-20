import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/storage/failure.dart';

import '../entities/character_model.dart';
import '../repositories/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<Either<Failure, List<CharacterModel>>> call() async {
    return await repository.getCharacters();
  }
}

class GetCharacterById {
  final CharacterRepository repository;

  GetCharacterById(this.repository);

  Future<Either<Failure, CharacterModel>> call(int id) async {
    return await repository.getCharacterById(id);
  }
}

class GetCharacterDetails {
  final CharacterRepository repository;

  GetCharacterDetails(this.repository);

  Future<Either<Failure, CharacterModel>> call(int characterId) async {
    return await repository.getCharacterDetails(characterId);
  }
}
class ToggleCharacterLike {
  final CharacterRepository repository;

  ToggleCharacterLike(this.repository);

  Future<Either<Failure, void>> call(int characterId) async {
    return await repository.toggleCharacterLike(characterId);
  }
}
