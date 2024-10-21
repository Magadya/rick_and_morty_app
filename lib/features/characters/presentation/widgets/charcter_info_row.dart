import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty_app/config/theme/app_theme.dart';

class CharacterInfoRow extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;

  const CharacterInfoRow({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primary,
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                context.colors.background,
                BlendMode.srcIn,
              ),
              fit: BoxFit.none,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.texts.labelMedium?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: context.texts.titleMedium?.copyWith(
                    color: context.colors.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
