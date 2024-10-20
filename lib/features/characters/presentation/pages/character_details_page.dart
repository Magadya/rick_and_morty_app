import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty_app/config/extentsions/string.dart';
import 'package:rick_and_morty_app/config/helpers/assets.dart';
import 'package:rick_and_morty_app/config/theme/app_theme.dart';
import '../../domain/entities/character_model.dart';
import '../stores/character_details_store.dart';
import '../../../../core/di/injection_container.dart';
import '../utils/character_icon_helper.dart';
import '../widgets/character_grid_item.dart';
import '../widgets/charcter_info_row.dart';

// CharacterDetailsPage widget
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
            return _buildErrorState();
          }

          return _buildContent(context, _store.character!);
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_store.error!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _store.loadCharacterDetails(widget.characterId),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, CharacterModel character) {
    final speciesIcon = CharacterIconHelper.getSpeciesIcon(character.species);
    final genderIcon = CharacterIconHelper.getGenderIcon(character.gender);
    final statusIcon = CharacterIconHelper.getStatusIcon(character.status);

    return CustomScrollView(
      slivers: [
        _buildAppBar(context, character),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCharacterInfo(character, speciesIcon, genderIcon, statusIcon),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, CharacterModel character) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 4,
      pinned: true,
      leading: _buildBackButton(context),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'character_image_${character.id}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(character.image, fit: BoxFit.cover),
              _buildGradientOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.background,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: SvgPicture.asset(AssetIconPath.arrowLeft24.path, width: 24, height: 24),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterInfo(CharacterModel character, String speciesIcon, String genderIcon, String statusIcon) {
    return Column(
      children: [
        CharacterInfoRow(
          iconPath: AssetIconPath.info24.path,
          label: 'Name',
          value: character.name.capitalize(),
        ),
        CharacterInfoRow(
          iconPath: statusIcon,
          label: 'Status',
          value: character.status.name.capitalize(),
        ),
        CharacterInfoRow(
          iconPath: speciesIcon,
          label: 'Species',
          value: character.species.name.capitalize(),
        ),
        CharacterInfoRow(
          iconPath: genderIcon,
          label: 'Gender',
          value: character.gender.name.capitalize(),
        ),
      ],
    );
  }
}
