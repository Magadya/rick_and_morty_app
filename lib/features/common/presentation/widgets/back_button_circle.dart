import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty_app/config/helpers/assets.dart';
import 'package:rick_and_morty_app/config/theme/app_theme.dart';

class BackButtonCircle extends StatelessWidget {
  const BackButtonCircle({super.key});

  @override
  Widget build(BuildContext context) {
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
}