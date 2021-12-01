import 'package:flutter/material.dart';

import '../../../core.dart';
import 'buttons_themes.dart';

/// Generates a [ThemeData] for the provided [BanksyUiPaletteBase]
ThemeData generateThemeData(BanksyUiPaletteBase palette) {
  /// A material [ColorScheme] that defines shades of colors from palette to be
  /// used on the generation of lighter themes
  final _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: palette.primary.main,
    primaryVariant: palette.primary.dark,
    onPrimary: palette.primary.contrast,
    secondary: palette.secondary.main,
    secondaryVariant: palette.secondary.dark,
    onSecondary: palette.secondary.contrast,
    surface: palette.white,
    onSurface: palette.black,
    background: palette.white,
    onBackground: palette.black,
    error: palette.error.main,
    onError: palette.error.contrast,
  );

  final typography = generateTypography(palette);

  return ThemeData(
    primarySwatch: palette.green,
    visualDensity: const VisualDensity(),
    colorScheme: _colorScheme,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    canvasColor: palette.white,
    dividerColor: palette.grey.shade900.withAlpha(0xDE),
    selectedRowColor: palette.grey[100],
    buttonTheme: ButtonThemeData(buttonColor: palette.primary.main),
    highlightColor: const Color(0x00000000),
    splashColor: const Color(0x00000000),
    // disable ink splash ion all the application
    indicatorColor: _colorScheme.onSurface,
    typography: typography,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: palette.green.shade900,
      foregroundColor: palette.white,
      titleTextStyle: typography.white.headline3,
      toolbarTextStyle: typography.white.bodyText1,
      iconTheme: IconThemeData(color: palette.white),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: palette.primary.main,
      hoverColor: palette.primary.dark,
      highlightElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
    ),
    tooltipTheme: TooltipThemeData(
      preferBelow: false,
      showDuration: Duration.zero,
      decoration: BoxDecoration(
        color: palette.green.shade900,
        boxShadow: [
          BoxShadow(
            color: palette.black.withOpacity(0.25),
            offset: const Offset(0.0, 1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 7.0,
        horizontal: 12.0,
      ),
      textStyle: TextStyle(
        fontSize: 12.0,
        color: palette.white,
        letterSpacing: 0.2,
      ),
    ),
    elevatedButtonTheme: generateElevateButtonTheme(palette),
    outlinedButtonTheme: generateOutlinedButtonTheme(palette),
    textButtonTheme: generateTextButtonTheme(palette),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
      alignLabelWithHint: true,
      isDense: true,
      labelStyle: TextStyle(
        height: 0,
        decorationColor: palette.grey.shade700,
        color: palette.grey.shade700,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        decorationColor: palette.grey.shade700,
        color: palette.grey.shade700,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: palette.grey.shade500),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: palette.black),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: palette.grey.shade500),
      ),
    ),
    dividerTheme: DividerThemeData(color: palette.grey.shade500, thickness: 1),
    hoverColor: palette.grey.shade300,
  );
}
