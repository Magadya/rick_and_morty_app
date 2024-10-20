import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/characters/presentation/pages/character_details_page.dart';
import '../../features/characters/presentation/pages/characters_page.dart';
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
    debugLogDiagnostics: true, // Helpful for debugging
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const CharactersPage(),
      ),
      GoRoute(
        name: 'character',
        path: '/character/:id',
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