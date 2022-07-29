// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

/// The maximum width taken up by each item on the home screen.
const maxHomeItemWidth = 1400.0;

/// Returns a boolean value whether the window is considered medium or large size.
///
/// When running on a desktop device that is also foldable, the display is not
/// considered desktop. Widgets using this method might consider the display is
/// large enough for certain layouts, which is not the case on foldable devices,
/// where only part of the display is available to said widgets.
///
/// Used to build adaptive and responsive layouts.
bool isDisplayDesktop(BuildContext context) {
  return getWindowType(context) >= AdaptiveWindowType.medium;
}

/// Returns boolean value whether the window is considered medium size.
///
/// Used to build adaptive and responsive layouts.
bool isDisplaySmallDesktop(BuildContext context) {
  return getWindowType(context) == AdaptiveWindowType.medium;
}
