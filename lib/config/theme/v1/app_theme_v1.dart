import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/config/theme/colors.dart';
import 'package:rick_and_morty_app/config/theme/rick_morty_app_theme.dart';

import 'app_text_theme_v1.dart';

class AppThemeV1 implements RickAndMortyAppTheme {
  @override
  final ThemeData theme = ThemeData.light().copyWith(
    textTheme: appTextThemeV1,
    colorScheme: _colorSchemeMVP,
    dividerColor: const Color(0xFFE8E8E8),
    shadowColor: const Color(0xFFC9DAEA),
    pageTransitionsTheme: _pageTransition,
    textButtonTheme: _textButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    scaffoldBackgroundColor: defaultAppColor,
  );

  @override
  final overlayStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  );

  @override
  final overlayStyleAlternative = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  );
}

final _colorSchemeMVP = const ColorScheme.light().copyWith(
  primary: defaultAppIrisBlueColor,
  secondary: const Color(0xFF80D676),
  background: defaultAppColor,
  error: const Color(0xFFF41F52),
  primaryContainer: defaultAppColor,
  surface: defaultAppColor2,
  surfaceVariant: const Color(0xFFF6F6F6),
  onPrimary: const Color(0xFF00214D),
  onSecondary: defaultAppColor,
  onBackground: defaultNeroBlackColor,
  onPrimaryContainer: defaultAppColor,
  onSurface: defaultGreyColor,
  onSurfaceVariant: const Color(0xFF2D3748),
);

const _pageTransition = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  },
);

final _textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
);
