import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/core/app/global_error_handler.dart';
import 'package:rick_and_morty_app/core/logger/logger_service.dart';
import 'package:rick_and_morty_app/core/navigator/app_navigation.dart';
import 'config/theme/theme.dart';
import 'core/di/injection_container.dart';
import 'core/services/i18n/global_i18n_handler.dart';
import 'core/services/i18n/i18n_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DevLogger.root.empty(lines: 2);
  DevLogger.root.infoWithDelimiters('app starting');
  SystemChrome.setSystemUIOverlayStyle(rickAndMortyAppTheme.overlayStyle);

  await initializeDependencies();
  await I18nService.init();

  DevLogger.root.infoWithDelimiters('main.dart services started');

  runApp(const GlobalI18nHandler(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalErrorHandler(
      child: MaterialApp.router(
        title: 'Rick and Morty',
        theme: rickAndMortyAppTheme.theme,
        routerConfig: AppNavigation().appRouter,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        supportedLocales: context.supportedLocales,

      ),
    );
  }
}