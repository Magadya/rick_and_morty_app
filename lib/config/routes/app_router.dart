import 'package:flutter/material.dart';
import '../../features/characters/presentation/pages/characters_page.dart';
import '../../features/characters/presentation/pages/character_details_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const CharactersPage(),
        );
      case '/character-details':
        final characterId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsPage(characterId: characterId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}