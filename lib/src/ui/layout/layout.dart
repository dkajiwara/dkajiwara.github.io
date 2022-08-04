import 'package:flutter/cupertino.dart';

import 'adaptive.dart';

double getHorizontalPadding(BuildContext context) {
  final isDesktop = isDisplayDesktop(context);
  final isTablet = isDisplaySmallDesktop(context);
  return isTablet
      ? 160.0
      : isDesktop
          ? 440.0
          : 16.0;
}
