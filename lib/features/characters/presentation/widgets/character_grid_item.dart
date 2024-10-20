import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty_app/config/extentsions/string.dart';
import 'package:rick_and_morty_app/config/helpers/assets.dart';
import 'package:rick_and_morty_app/config/theme/app_theme.dart';
import '../../domain/entities/character_model.dart';

class CharacterGridItem extends StatelessWidget {
  final CharacterModel character;
  final VoidCallback onTap;
  final VoidCallback onLikeTap;

  const CharacterGridItem({
    super.key,
    required this.character,
    required this.onTap,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: context.colors.surface,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.background,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: SvgPicture.asset(
                          character.isLiked ? AssetIconPath.like24.path : AssetIconPath.unlike24.path,
                          width: 20,
                          height: 20,
                        ),
                        onPressed: onLikeTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: context.colors.onBackground,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getStatusColor(character.status),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${character.status.name.capitalize()} - ${character.species.name.capitalize()}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: context.colors.onBackground,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(CharacterStatus status) {
    switch (status) {
      case CharacterStatus.alive:
        return Colors.green;
      case CharacterStatus.dead:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
