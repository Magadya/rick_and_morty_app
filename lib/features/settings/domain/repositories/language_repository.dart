abstract class LanguageRepository {
  Future<void> setLanguage(String languageCode, String countryCode);
  String getCurrentLanguageCode();
  String getCurrentCountryCode();
}