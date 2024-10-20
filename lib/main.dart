import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/core/app/global_error_handler.dart';
import 'package:rick_and_morty_app/core/logger/logger_service.dart';
import 'package:rick_and_morty_app/core/navigator/app_navigation.dart';
import 'config/theme/theme.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DevLogger.root.empty(lines: 2);
  DevLogger.root.infoWithDelimiters('app starting');
  SystemChrome.setSystemUIOverlayStyle(rickAndMortyAppTheme.overlayStyle);

  await initializeDependencies();

  DevLogger.root.infoWithDelimiters('main.dart services started');

  runApp(const MyApp());
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
        debugShowCheckedModeBanner: false, // Optional: removes debug banner
      ),
    );
  }
}