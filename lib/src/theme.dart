import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.zenKakuGothicNewTextTheme(),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: kIsWeb
        ? {
            for (final platform in TargetPlatform.values)
              platform: const NoTransitionsBuilder(),
          }
        : const {},
  ),
);

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget? child,
      ) {
    // only return the child without warping it with animations
    return child!;
  }
}
