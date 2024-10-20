import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/features/characters/presentation/stores/character_store.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../features/characters/presentation/stores/character_details_store.dart';
import '../api/api_client.dart';

import '../../features/characters/data/datasources/character_remote_datasource.dart';
import '../../features/characters/data/datasources/character_local_datasource.dart';
import '../../features/characters/data/repositories/character_repository_impl.dart';
import '../../features/characters/domain/repositories/character_repository.dart';
import '../../features/characters/domain/usecases/get_characters.dart';
import '../storage/local_storage.dart';


final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => ApiClient());
  getIt.registerLazySingleton(() => LocalStorage(getIt()));

  // Data sources
  getIt.registerLazySingleton<CharacterRemoteDataSource>(
        () => CharacterRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<CharacterLocalDataSource>(
        () => CharacterLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<CharacterRepository>(
        () => CharacterRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetCharacters(getIt()));
  getIt.registerLazySingleton(() => GetCharacterDetails(getIt()));
  getIt.registerLazySingleton(() => ToggleCharacterLike(getIt()));

  // Store
  getIt.registerLazySingleton(
        () => CharacterStore(
      getCharacters: getIt(),
      toggleCharacterLike: getIt(),
    ),
  );

  getIt.registerFactory(
        () => CharacterDetailsStore(
      getCharacterDetails: getIt(),
      toggleCharacterLike: getIt(),
    ),
  );

}