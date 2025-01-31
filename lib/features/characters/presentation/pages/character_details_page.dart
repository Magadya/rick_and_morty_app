import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rick_and_morty_app/core/di/injection_container.dart';
import 'package:rick_and_morty_app/features/characters/presentation/stores/character_details_store.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/character_details_content.dart';
import 'package:rick_and_morty_app/features/common/presentation/widgets/error_view.dart';

class CharacterDetailsPage extends StatefulWidget {
  final int characterId;

  const CharacterDetailsPage({
    super.key,
    required this.characterId,
  });

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  late final CharacterDetailsStore _store;

  @override
  void initState() {
    super.initState();
    _store = getIt<CharacterDetailsStore>();
    _store.loadCharacterDetails(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_store.error != null) {
            return ErrorView(
              error: _store.error!,
              onRetry: () => _store.loadCharacterDetails(widget.characterId),
            );
          }

          return CharacterDetailsContent(character: _store.character!);
        },
      ),
    );
  }
}