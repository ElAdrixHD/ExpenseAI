import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/config/design.dart';
import '/resources/themes/styles/color_styles.dart';
import '/resources/themes/text_theme/default_text_theme.dart';

/* Light Theme
|--------------------------------------------------------------------------
| Theme Config - config/theme.dart
|-------------------------------------------------------------------------- */

ThemeData lightTheme(ColorStyles color) {
  TextTheme lightTheme =
      getAppTextTheme(appFont, defaultTextTheme.merge(_textTheme(color)));

  return ThemeData(
    useMaterial3: true,
    primaryColor: color.primaryAccent,
    primaryColorLight: const Color(0xFF9AC8DE),
    focusColor: color.content,
    scaffoldBackgroundColor: color.background,
    hintColor: color.primaryAccent,
    dividerTheme: DividerThemeData(color: const Color(0xFFE0E0E0)),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: color.appBarBackground,
      titleTextStyle:
          lightTheme.titleLarge!.copyWith(color: color.appBarPrimaryContent),
      iconTheme: IconThemeData(color: color.appBarPrimaryContent),
      elevation: 1.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: color.buttonContent,
      colorScheme: ColorScheme.light(primary: color.buttonBackground),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: color.primaryAccent),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: color.buttonContent,
          backgroundColor: color.buttonBackground),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: color.bottomTabBarBackground,
      unselectedIconTheme:
          IconThemeData(color: color.bottomTabBarIconUnselected),
      selectedIconTheme: IconThemeData(color: color.bottomTabBarIconSelected),
      unselectedLabelStyle: TextStyle(color: color.bottomTabBarLabelUnselected),
      selectedLabelStyle: TextStyle(color: color.bottomTabBarLabelSelected),
      selectedItemColor: color.bottomTabBarLabelSelected,
    ),
    textTheme: lightTheme,
    colorScheme: ColorScheme.light(
      surface: color.background,
      onSecondary: Colors.white,
      primary: color.primaryAccent,
    ),
  );
}

/* Light Text Theme
|-------------------------------------------------------------------------*/

TextTheme _textTheme(ColorStyles colors) {
  TextTheme textTheme = const TextTheme().apply(displayColor: colors.content);
  return textTheme.copyWith(
      labelLarge:
          TextStyle(color: colors.content.withAlpha((255.0 * 0.8).round())));
}
