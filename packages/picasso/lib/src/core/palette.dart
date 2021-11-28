import 'package:flutter/material.dart';
import 'data.dart';

/// Description of color palette on picasso themes
///
/// It will be used by [PicassoData] to generate theme data for flutter widgets
///
/// See also:
/// * [PicassoPalette] : The default implementation of this class
/// * [PicassoData] : Uses a [PicassoPaletteBase] to generate flutter themes
///
abstract class PicassoPaletteBase {
  final MaterialColor purple;
  final MaterialColor mint;
  final MaterialColor red;
  final MaterialColor orange;
  final MaterialColor green;
  final MaterialColor blue;
  final MaterialColor periwinkle;
  final MaterialColor cobalt;
  final MaterialColor gold;
  final MaterialColor yellow;
  final MaterialColor lily;
  final MaterialColor maroon;
  final MaterialColor poppy;
  final MaterialColor grey;

  final Color white;
  final Color black;
  final Color transparent;

  final ColorFamily primary;
  final ColorFamily secondary;
  final ColorFamily error;
  final ColorFamily warning;
  final ColorFamily info;
  final ColorFamily success;

  final TextColorFamily text;

  PicassoPaletteBase({
    required this.purple,
    required this.mint,
    required this.red,
    required this.orange,
    required this.green,
    required this.blue,
    required this.periwinkle,
    required this.cobalt,
    required this.gold,
    required this.yellow,
    required this.lily,
    required this.maroon,
    required this.poppy,
    required this.grey,
    required this.white,
    required this.black,
    required this.primary,
    required this.secondary,
    required this.error,
    required this.warning,
    required this.info,
    required this.success,
    required this.text,
    required this.transparent,
  });
}

/// A default implementation of [PicassoPaletteBase] with predefined colors.
class PicassoPalette implements PicassoPaletteBase {
  @override
  late final MaterialColor blue = const MaterialColor(
    0xFF5D9EFA,
    <int, Color>{
      200: Color(0xFFDAE9FD),
      300: Color(0xFFBED8FD),
      500: Color(0xFF5D9EFA),
      900: Color(0xFF264065),
    },
  );

  @override
  late final MaterialColor cobalt = const MaterialColor(
    0xFF423C95,
    <int, Color>{
      200: Color(0xFFD4D4F9),
      300: Color(0xFFBDBDF8),
      400: Color(0xFF928BEE),
      500: Color(0xFF423C95),
      600: Color(0xFF393484),
      900: Color(0xFF242253),
    },
  );

  @override
  late final MaterialColor gold = const MaterialColor(
    0xFFEDC971,
    <int, Color>{
      200: Color(0xFFFEF5DD),
      400: Color(0xFFFDE8B7),
      500: Color(0xFFEDC971),
      900: Color(0xFF493E23),
    },
  );

  @override
  late final MaterialColor green = const MaterialColor(
    0xFF27A083,
    <int, Color>{
      200: Color(0xFFCEF6EC),
      500: Color(0xFF27A083),
      900: Color(0xFF0C3128),
    },
  );

  @override
  late final MaterialColor lily = const MaterialColor(
    0xFFFBF9F0,
    <int, Color>{
      500: Color(0xFFFBF9F0),
    },
  );

  @override
  late final MaterialColor maroon = const MaterialColor(
    0xFF,
    <int, Color>{
      200: Color(0xFFE9E3E7),
      300: Color(0xFFD3C7D0),
      500: Color(0xFF9D8196),
      600: Color(0xFF754F6C),
      700: Color(0xFF5B3452),
      900: Color(0xFF3A032D),
    },
  );

  @override
  late final MaterialColor mint = const MaterialColor(
    0xFF4FD5B3,
    <int, Color>{
      200: Color(0xFFD3F5EC),
      300: Color(0xFFB2EDDD),
      500: Color(0xFF4FD5B3),
      600: Color(0xFF4AC7A5),
      700: Color(0xFF42B294),
      900: Color(0xFF1A473B),
    },
  );

  @override
  late final MaterialColor orange = const MaterialColor(
    0xFFF29D0B,
    <int, Color>{
      200: Color(0xFFFDEACC),
      300: Color(0xFFF9D69A),
      500: Color(0xFFF29D0B),
      900: Color(0xFF593804),
    },
  );

  @override
  late final MaterialColor periwinkle = const MaterialColor(
    0xFF9797FF,
    <int, Color>{
      200: Color(0xFF9797FF),
      300: Color(0xFFDCDCFC),
      400: Color(0xFFCFCFFF),
      500: Color(0xFF9797FF),
      900: Color(0xFF3B3B64),
    },
  );

  @override
  late final MaterialColor poppy = const MaterialColor(
    0xFFFE5537,
    <int, Color>{
      200: Color(0xFFFFEEEB),
      500: Color(0xFFFE5537),
      700: Color(0xFFB23C27),
      900: Color(0xFF7F2B1C),
    },
  );

  @override
  late final MaterialColor purple = const MaterialColor(
    0xFF6D30E7,
    <int, Color>{
      100: Color(0xFFF0EFF5),
      200: Color(0xFFEEE7FC),
      300: Color(0xFFE1D3FB),
      500: Color(0xFF6D30E7),
      600: Color(0xFF622CD2),
      700: Color(0xFF5827BD),
      900: Color(0xFF371A74),
    },
  );

  @override
  late final MaterialColor red = const MaterialColor(
    0xFFE92F3C,
    <int, Color>{
      200: Color(0xFFFBD9DB),
      300: Color(0xFFF8BBBF),
      500: Color(0xFFE92F3C),
      900: Color(0xFF7B191F),
    },
  );

  @override
  late final MaterialColor yellow = const MaterialColor(
    0xFFFFC800,
    <int, Color>{
      50: Color(0xFFFFF6D4),
      100: Color(0xFFFFF6D4),
      200: Color(0xFFFFF6D4),
      300: Color(0xFFFFE480),
      350: Color(0xFFFFE480),
      400: Color(0xFFFFE480),
      500: Color(0xFFFFC800),
      600: Color(0xFFF0BC00),
      700: Color(0xFFDFAF00),
      800: Color(0xFFDFAF00),
      850: Color(0xFFDFAF00),
      900: Color(0xFF4C3C00),
    },
  );

  @override
  late final MaterialColor grey = const MaterialColor(
    0xFFC2C2C2,
    <int, Color>{
      50: Color(0xFFF7F7F7),
      100: Color(0xFFF7F7F7),
      200: Color(0xFFF1F1F1),
      300: Color(0xFFEAEAEA),
      350: Color(0xFFEAEAEA),
      400: Color(0xFFE1E1E1),
      500: Color(0xFFC2C2C2),
      600: Color(0xFF989898),
      700: Color(0xFF6F6F6F),
      800: Color(0xFF4C4C4C),
      850: Color(0xFF4C4C4C),
      900: Color(0xFF2C2C2C),
    },
  );

  @override
  late final Color black = const Color(0xFF1A1A1A);

  @override
  late final Color white = const Color(0xFFFFFFFF);

  @override
  late final Color transparent = const Color(0x00000000);

  @override
  late final ColorFamily error = ColorFamily(
    main: red.shade500,
    light: red.shade200,
    dark: red.shade900,
    contrast: white,
  );

  @override
  late final ColorFamily info = ColorFamily(
    main: blue.shade500,
    light: blue.shade200,
    dark: blue.shade900,
    contrast: black.withAlpha(0xDE),
  );

  @override
  late final ColorFamily primary = ColorFamily(
    main: yellow.shade500,
    light: yellow.shade300,
    dark: yellow.shade600,
    contrast: black,
  );

  @override
  late final ColorFamily secondary = ColorFamily(
    main: mint.shade500,
    light: mint.shade300,
    dark: mint.shade600,
    contrast: white,
  );

  @override
  late final ColorFamily warning = ColorFamily(
    main: orange.shade500,
    light: orange.shade200,
    dark: orange.shade900,
    contrast: black.withAlpha(0xDE),
  );

  @override
  late final ColorFamily success = ColorFamily(
    main: green.shade200,
    light: green.shade500,
    dark: green.shade900,
    contrast: white,
  );

  @override
  late final TextColorFamily text = TextColorFamily(
    primary: black,
    secondary: grey.shade700,
    disabled: black.withOpacity(0.38),
    hint: black.withOpacity(0.38),
  );

  static PicassoPaletteBase of(BuildContext context) {
    return PicassoData.of(context).palette;
  }
}

/// Defines a group of shades of colors that may relate to each other
@immutable
class ColorFamily {
  /// The main defined color
  final Color main;

  /// A lighter version of [main]
  final Color light;

  /// A darker version of [main]
  final Color dark;

  /// A color in which should be visible against surfaces with [main] color
  final Color contrast;

  const ColorFamily({
    required this.main,
    required this.light,
    required this.dark,
    required this.contrast,
  });
}

/// Defines a group of colors related to a theme of general text colors
@immutable
class TextColorFamily {
  /// The main text color
  final Color primary;

  /// The alternative text color
  final Color secondary;

  /// Color for general disabled state of text
  final Color disabled;

  final Color hint;

  const TextColorFamily({
    required this.primary,
    required this.secondary,
    required this.disabled,
    required this.hint,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextColorFamily &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          secondary == other.secondary &&
          disabled == other.disabled &&
          hint == other.hint;

  @override
  int get hashCode =>
      primary.hashCode ^ secondary.hashCode ^ disabled.hashCode ^ hint.hashCode;
}
