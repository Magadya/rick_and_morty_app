import 'dart:ui';

import 'package:flutter/material.dart';

final _mainFontFamily = TextStyle(
  fontFamily: _FamilyName.lato.name,
  fontWeight: FontWeight.w400,
);

final appTextThemeV1 = TextTheme(
  titleLarge: _mainFontFamily.copyWith(
    fontSize: 20,
    height: 1,
    fontWeight: FontWeight.w700,
  ),

  ///subtitle_bold 16
  titleMedium: _mainFontFamily.copyWith(
    fontSize: 16,
    height: 1,
    fontWeight: FontWeight.w700,
  ),

  titleSmall: _mainFontFamily.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),

  /// body_bold14
  ///body_medium 14
  bodyMedium: _mainFontFamily.copyWith(
    fontSize: 14,
    height: 1,
    fontWeight: FontWeight.w700,
  ),

  bodySmall: _mainFontFamily.copyWith(
    fontSize: 12,
    height: 1,
    fontWeight: FontWeight.w700,
  ),

  ///caption_bold 12
  ///caption_medium 12
  labelMedium: _mainFontFamily.copyWith(
    fontSize: 12,
    height: 1,
    fontWeight: FontWeight.w500,
  ),

  /// caption8Mono
  labelSmall: _mainFontFamily.copyWith(
    fontSize: 8,
    height: 1.5,
  ),
);

enum _FamilyName {
  lato,
  ;

  String get name => switch (this) {
        lato => 'Lato',
      };
}
