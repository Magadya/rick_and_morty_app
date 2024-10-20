// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/theme/app_theme_sizes.dart';


extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get texts => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  AppThemeSizes get sizes => theme.extension<AppThemeSizes>()!;
}

