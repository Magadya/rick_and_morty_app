import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/storage/local_storage.dart';
import '../../domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final BuildContext context;
  final LocalStorage localStorage;

  LanguageRepositoryImpl(this.context, this.localStorage);

  @override
  Future<void> setLanguage(String languageCode, String countryCode) async {
    await context.setLocale(Locale(languageCode, countryCode));
    await localStorage.setLanguage(languageCode, countryCode);
  }

  @override
  String getCurrentLanguageCode() {
    return localStorage.getLanguageCode();
  }

  @override
  String getCurrentCountryCode() {
    return localStorage.getCountryCode();
  }
}