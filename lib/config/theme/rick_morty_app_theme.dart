import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class RickAndMortyAppTheme {
  ThemeData get theme;

  SystemUiOverlayStyle get overlayStyle;

  SystemUiOverlayStyle get overlayStyleAlternative;
}
