import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/theme/app_theme.dart';

class AppButtonStyleV1 {
  static ButtonStyle filledPrimary(BuildContext context) =>
      FilledButton.styleFrom(
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
      );

  static ButtonStyle filledOnPrimary(BuildContext context) => ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(context.colors.onPrimary),
        foregroundColor: MaterialStatePropertyAll(context.colors.primary),
      );

  static ButtonStyle filledOnPrimaryWithOpacity(BuildContext context) =>
      ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
            context.colors.onPrimary.withOpacity(0.08)),
        foregroundColor: MaterialStatePropertyAll(context.colors.primary),
      );

  static ButtonStyle filledSecondaryContainer(BuildContext context) =>
      FilledButton.styleFrom(
        backgroundColor: context.colors.secondaryContainer,
        foregroundColor: context.colors.onSecondaryContainer,
      );

  static ButtonStyle filledTertiary(BuildContext context) => ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(context.colors.tertiary),
        foregroundColor: MaterialStatePropertyAll(context.colors.onTertiary),
      );

  static ButtonStyle disabledTertiary(BuildContext context) =>
      OutlinedButton.styleFrom(
        disabledForegroundColor: context.colors.onTertiary.withOpacity(0.5),
      );

  static ButtonStyle filledError(BuildContext context) => ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(context.colors.errorContainer),
        foregroundColor:
            MaterialStatePropertyAll(context.colors.onErrorContainer),
      );

  static ButtonStyle backgroundColor(Color color) => ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
      );

  static ButtonStyle onPrimarySecondary(BuildContext context) => ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          context.colors.surface.withOpacity(0.08),
        ),
        foregroundColor: MaterialStatePropertyAll(context.colors.onPrimary),
      );

  static ButtonStyle outlinedPrimary(BuildContext context) =>
      OutlinedButton.styleFrom(
        side: BorderSide(color: context.colors.primary),
        foregroundColor: context.colors.onBackground,
        splashFactory: NoSplash.splashFactory,
      );

  static ButtonStyle get fullWidth64 => const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 64)),
        maximumSize: MaterialStatePropertyAll(Size(double.infinity, 64)),
      );

  static ButtonStyle get fullWidth48 => const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 48)),
        maximumSize: MaterialStatePropertyAll(Size(double.infinity, 48)),
      );

  static ButtonStyle get bottomCentered => const ButtonStyle(
        alignment: Alignment.bottomCenter,
      );

  static ButtonStyle get alignedLeft => const ButtonStyle(
        alignment: Alignment.centerLeft,
      );

  static ButtonStyle get extendedHorizontally => const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 45)),
      );

  static ButtonStyle small(BuildContext context) => ButtonStyle(
        textStyle: MaterialStatePropertyAll(context.texts.bodyMedium),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
        minimumSize: const MaterialStatePropertyAll(Size(0, 40)),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      );

  static ButtonStyle foregroundColor(Color color) => ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(color),
      );

  static ButtonStyle get small32 => const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
        minimumSize: MaterialStatePropertyAll(Size(32, 32)),
      );
}
