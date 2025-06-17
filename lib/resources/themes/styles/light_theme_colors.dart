import 'package:flutter/material.dart';

import '/resources/themes/styles/color_styles.dart';

/* Light Theme Colors
|-------------------------------------------------------------------------- */

class LightThemeColors implements ColorStyles {
  // general
  @override
  Color get background => Colors.white;

  @override
  Color get content => const Color(0xFF1A1A1A);

  @override
  Color get primaryAccent => const Color(0xFF6366F1);
  @override
  Color get surfaceBackground => const Color(0xFFF8FAFC);

  @override
  Color get surfaceContent => const Color(0xFF18161F);

  // app bar
  @override
  Color get appBarBackground => const Color(0xFF6366F1);
  @override
  Color get appBarPrimaryContent => Colors.white;

  // buttons
  @override
  Color get buttonBackground => const Color(0xFF6366F1);
  @override
  Color get buttonContent => Colors.white;

  @override
  Color get buttonSecondaryBackground => const Color(0xFFE2E8F0);
  @override
  Color get buttonSecondaryContent => const Color(0xFF475569);

  // bottom tab bar
  @override
  Color get bottomTabBarBackground => Colors.white;

  // bottom tab bar - icons
  @override
  Color get bottomTabBarIconSelected => const Color(0xFF6366F1);
  @override
  Color get bottomTabBarIconUnselected => const Color(0xFF94A3B8);

  // bottom tab bar - label
  @override
  Color get bottomTabBarLabelUnselected => const Color(0xFF94A3B8);
  @override
  Color get bottomTabBarLabelSelected => const Color(0xFF6366F1);

  // toast notification
  @override
  Color get toastNotificationBackground => const Color(0xFFF8FAFC);
}
