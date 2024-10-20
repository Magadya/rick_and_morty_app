import 'package:flutter/material.dart';

class AppThemeSizes extends ThemeExtension<AppThemeSizes> {
  final double screenContentHorizontalPadding;
  final double screenContentAlternativePadding;
  final double bottomSafeAreaPadding;
  final double bigPageTitlePadding;

  const AppThemeSizes({
    this.screenContentHorizontalPadding = 32,
    this.screenContentAlternativePadding = 44,
    this.bottomSafeAreaPadding = 16,
    this.bigPageTitlePadding = 32,
  });

  /// unused for now
  @override
  AppThemeSizes lerp(AppThemeSizes? other, double t) {
    if (other is! AppThemeSizes) {
      return this;
    }
    return other;
  }

  /// unused for now
  @override
  AppThemeSizes copyWith() {
    return const AppThemeSizes();
  }
}
