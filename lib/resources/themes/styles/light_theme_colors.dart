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

  // form fields
  @override
  Color get formFieldBackground => Colors.white;
  @override
  Color get formFieldBorder => const Color(0xFFD1D5DB);
  @override
  Color get formFieldFocusedBorder => const Color(0xFF6366F1);
  @override
  Color get formFieldHintText => const Color(0xFF9CA3AF);
  @override
  Color get formFieldLabelText => const Color(0xFF374151);
  @override
  Color get formFieldSuffixIcon => const Color(0xFF6B7280);
  @override
  Color get formFieldSuccessBorder => const Color(0xFF10B981);
  @override
  Color get formFieldErrorBorder => const Color(0xFFEF4444);
}
