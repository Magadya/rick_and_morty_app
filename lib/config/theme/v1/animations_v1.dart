import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';

class AppAnimationsV1 {
  static List<Effect> fadeVerticalSlide({
    int index = 0,
    delayMultiplier = 200,
    slideOffset = -.1,
  }) {
    final delay = (index * delayMultiplier).milliseconds;

    return [
      FadeEffect(
        delay: delay,
      ),
      SlideEffect(
        begin: Offset(0, slideOffset),
        delay: delay,
      ),
    ];
  }
}
