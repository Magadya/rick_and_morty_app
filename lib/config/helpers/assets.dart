import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty_app/config/theme/app_theme.dart';

// enum AssetImagePath {
//   appIcon,
//   signUpImage,
//   ;
//
//   String get _root => 'assets/images';
//
//   String get png => switch (this) {
//     _ => '$_root/${name.camelToSneakCase()}.png',
//   };
//
//   String get webp => switch (this) {
//         _ => '$_root/${name.camelToSneakCase()}.webp',
//       };
// }

enum AssetIconPath {
  arrowLeft24,
  info24,
  unlike24,
  like24,
  genderMale24,
  genderFemale24,
  genderUnknown24,
  speciesAlien24,
  speciesHuman24,
  statusAlive24,
  statusDead24,
  statusUnknown24,
  ;

  String get _root => 'assets/icons';

  String get path => switch (this) {
        _ => '$_root/${name.camelToSneakCase()}.svg',
      };

  Widget iconInCircle(
    BuildContext context, {
    Color? color,
    Color? circleColor,
    double size = 24.0,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor ?? context.colors.onSurface.withOpacity(.04),
      ),
      // ignore: deprecated_member_use
      child: Center(child: SvgPicture.asset(path, color: color)),
    );
  }
}

extension on String {
  String camelToSneakCase() {
    return replaceAllMapped(RegExp(r'(?<=[a-z])(?=[A-Z0-9])|(?<=[0-9])(?=[A-Z])'), (Match match) {
      return '_';
    }).toLowerCase();
  }
}
