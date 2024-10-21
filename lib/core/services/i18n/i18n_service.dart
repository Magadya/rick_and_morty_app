import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';


import '../../logger/logger_service.dart';

class I18nService {
  static final _log = DevLogger('i18n');
  static const String basePath = 'assets/translations';

  static Locale get defaultLocale => const Locale('en', 'US');

  static List<Locale> supportedLocales = [
    defaultLocale,
    const Locale('ru', 'RU'),
  ];

  static Future<void> init() async {
    _configureLogger();

    await EasyLocalization.ensureInitialized();
  }

  static void _configureLogger() {
    EasyLocalization.logger.printer = (
      Object object, {
      name,
      StackTrace? stackTrace,
      level,
    }) {
      switch (level.toString()) {
        case 'LevelMessages.error':
          _log.error(object.toString(), null, stackTrace ?? StackTrace.empty);
          return;
        case 'LevelMessages.warning':
          _log.warning(object.toString(), null, stackTrace ?? StackTrace.empty);
          return;
        case 'LevelMessages.info':
          // _log.info(object.toString());
          return;
        case 'LevelMessages.debug':
          // _log.debug(object.toString());
          return;
        default:
          return;
      }
    };
  }


  static Locale get defaultOriginLocale => const Locale('en', 'US');

  static Locale get defaultTranslationLocale => const Locale('es', 'ES');
}

extension LocaleContextExtension on BuildContext {
  String tLangName(String key) => 'languages_pages.languageNames.$key'.tr();

  String tWordListSortBy(String key) => 'word_list_page.sortBy.$key'.tr();

  String tInterfaceLangName(String key) => 'languages_pages.interfaceLanguageNames.$key'.tr();

  String trWeekName(int weekNumber) {
    final key = switch (weekNumber) {
      1 => 'monday',
      2 => 'tuesday',
      3 => 'wednesday',
      4 => 'thursday',
      5 => 'friday',
      6 => 'saturday',
      7 => 'sunday',
      _ => throw 'Invalid week number: $weekNumber',
    };
    return 'durations.weekNameShort.$key'.tr();
  }

  @Deprecated('use String.tr() instead')
  String t(String key, {List<String>? variables}) => key.replaceAll(':', '.').tr();
}
