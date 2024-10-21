import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/core/services/i18n/locale_key.g.dart';
import '../../../../core/navigator/routes.dart';
import '../stores/character_store.dart';
import '../widgets/character_grid_item.dart';
import '../../../../core/di/injection_container.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final CharacterStore _store = getIt<CharacterStore>();

  @override
  void initState() {
    super.initState();
    _store.loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKey.characterPagePageTitle.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goNamed(RouteName.languageSettings.name),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_store.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_store.error!),
                  ElevatedButton(
                    onPressed: _store.loadCharacters,
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _store.characters.length,
            itemBuilder: (context, index) {
              final character = _store.characters[index];
              return CharacterGridItem(
                  character: character,
                  onLikeTap: () => _store.toggleLike(character.id),
                  onTap: () => context.pushNamed(
                        'character',
                        pathParameters: {'id': character.id.toString()},
                      ));
            },
          );
        },
      ),
    );
  }
}
