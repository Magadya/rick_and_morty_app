import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/core/navigator/routes.dart';
import '../../features/characters/presentation/pages/character_details_page.dart';
import '../../features/characters/presentation/pages/characters_page.dart';
import '../../features/settings/presentation/pages/language_settings_pages.dart';
class AppNavigation {
  static final AppNavigation _instance = AppNavigation._internal();

  factory AppNavigation() {
    return _instance;
  }

  final globalRouteKey = GlobalKey<NavigatorState>(debugLabel: 'global');

  AppNavigation._internal();

  late final GoRouter appRouter = GoRouter(
    navigatorKey: globalRouteKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: RouteName.home.name,
        path: RouteName.home.path,
        builder: (context, state) => const CharactersPage(),
      ),
      GoRoute(
        name: RouteName.character.name,
        path: RouteName.character.path,
        builder: (context, state) {
          final String? characterId = state.pathParameters['id'];
          if (characterId == null || int.tryParse(characterId) == null) {
            return const Scaffold(
              body: Center(child: Text('Error: Invalid Character ID')),
            );
          }
          final int id = int.parse(characterId);
          return CharacterDetailsPage(characterId: id);
        },
      ),
      GoRoute(
        name: RouteName.languageSettings.name,
        path: RouteName.languageSettings.path,
        builder: (context, state) => const LanguageSettingsPage(),
      ),
    ],
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(
          child: Text('Error: Page not found!'),
        ),
      );
    },
  );
}