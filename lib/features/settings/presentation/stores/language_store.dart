import 'package:mobx/mobx.dart';

import '../../domain/entities/language_entity.dart';
import '../../domain/repositories/language_repository.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  final LanguageRepository _repository;

  _LanguageStore(this._repository);

  @observable
  String currentLanguageCode = '';

  @observable
  String currentCountryCode = '';

  @computed
  bool get isEnglish => currentLanguageCode == 'en';

  @computed
  bool get isRussian => currentLanguageCode == 'ru';

  @action
  Future<void> init() async {
    currentLanguageCode = _repository.getCurrentLanguageCode();
    currentCountryCode = _repository.getCurrentCountryCode();
  }

  @action
  Future<void> setLanguage(LanguageEntity language) async {
    await _repository.setLanguage(language.code, language.countryCode);
    currentLanguageCode = language.code;
    currentCountryCode = language.countryCode;
  }
}