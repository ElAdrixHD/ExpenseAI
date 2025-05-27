import 'package:flutter/material.dart';

import '/resources/themes/styles/color_styles.dart';

/* Dark Theme Colors
|-------------------------------------------------------------------------- */

class DarkThemeColors implements ColorStyles {
  // general
  @override
  Color get background => const Color(0xFF18161F);

  @override
  Color get content => const Color(0xFFE1E1E1);
  @override
  Color get primaryAccent => const Color(0xFF9AC8DE);

  @override
  Color get surfaceBackground => const Color(0xFF2A2833);
  @override
  Color get surfaceContent => Colors.white;

  // app bar
  @override
  Color get appBarBackground => const Color(0xFF2A2833);
  @override
  Color get appBarPrimaryContent => Colors.white;

  // buttons
  @override
  Color get buttonBackground => const Color(0xFF585BA0);
  @override
  Color get buttonContent => Colors.white;

  @override
  Color get buttonSecondaryBackground => const Color(0xFF9AC8DE);
  @override
  Color get buttonSecondaryContent => const Color(0xFF18161F);

  // bottom tab bar
  @override
  Color get bottomTabBarBackground => const Color(0xFF2A2833);

  // bottom tab bar - icons
  @override
  Color get bottomTabBarIconSelected => const Color(0xFF9AC8DE);
  @override
  Color get bottomTabBarIconUnselected => const Color(0xFF585BA0);

  // bottom tab bar - label
  @override
  Color get bottomTabBarLabelUnselected => const Color(0xFF585BA0);
  @override
  Color get bottomTabBarLabelSelected => const Color(0xFF9AC8DE);

  // toast notification
  @override
  Color get toastNotificationBackground => const Color(0xFF2A2833);
}
