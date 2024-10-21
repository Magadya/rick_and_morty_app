import 'package:csv/csv.dart';

const converterToCsv = ListToCsvConverter();
const converterToList = CsvToListConverter();

class LocaleCsvEntity {
  final String key;
  final String en;
  final Map<String, String> translations;

  LocaleCsvEntity({
    required this.key,
    required String en,
    required this.translations,
  }) : en = en.trim();

  factory LocaleCsvEntity.fromList(List<String> list, List<String> languages) {
    String getValue(index) => list.length > index ? list[index] : '';
    final translations = languages
        .asMap()
        .map((key, value) => MapEntry(value, getValue(key + 2)));

    return LocaleCsvEntity(
      key: list[0],
      en: list[1],
      translations: translations,
    );
  }

  String get csv {
    final values = [key, en, ...translations.values];
    return converterToCsv.convertSingleRow(StringBuffer(), values) ?? '';
  }

  String get csvEn {
    return [key, en, ...translations.values].join(',');
  }

  String? getTranslation(String lang) {
    final res = translations[lang];
    return res == null || res.isEmpty ? null : res;
  }

  void setTranslation(String? text, String lang) {
    final preparedValue = addPlaceholders(text ?? '').replaceAll('&#39;', "'");

    translations[lang] = preparedValue;
  }

  dynamic removePlaceholders(String value) {
    return Injection.replaceToValues(value);
  }

  dynamic addPlaceholders(String value) {
    return Injection.replaceToCsv(value);
  }
}

class Injection {
  final String injection;
  final String replacer;

  Injection(this.injection, this.replacer);

  static Injection get lang => Injection('{lang}', '#1#');
  static Injection get min => Injection('{min}', '#2#');
  static Injection get max => Injection('{max}', '#3#');
  static Injection get value => Injection('{value}', '#4#');

  static String replaceToCsv(String value) => [lang, min].fold(
        value,
        (acc, cur) => acc.replaceAll(cur.replacer, cur.injection),
      );

  static String replaceToValues(String value) => [lang, min].fold(
        value,
        (acc, cur) => acc.replaceAll(cur.injection, cur.replacer),
      );
}
