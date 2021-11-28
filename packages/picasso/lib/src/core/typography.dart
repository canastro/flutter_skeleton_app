import 'package:flutter/material.dart';
import '../../core.dart';

/// Defines the group of fonts used on a picasso app
const _kFontFallbacks = ['.AppleSystemUIFont', 'Roboto'];

const _kFontFamily = 'packages/picasso/Urbanist';

// A text theme to define font families
const _kPicassoFontFamilyTextTheme = TextTheme(
  headline1: TextStyle(fontFamily: _kFontFamily),
  headline2: TextStyle(fontFamily: _kFontFamily),
  headline3: TextStyle(fontFamily: _kFontFamily),
  headline4: TextStyle(fontFamily: _kFontFamily),
  headline5: TextStyle(fontFamily: _kFontFamily),
  headline6: TextStyle(fontFamily: _kFontFamily),
  bodyText1: TextStyle(fontFamily: _kFontFamily),
  bodyText2: TextStyle(fontFamily: _kFontFamily),
  subtitle1: TextStyle(fontFamily: _kFontFamily),
  subtitle2: TextStyle(fontFamily: _kFontFamily),
  caption: TextStyle(fontFamily: _kFontFamily),
  button: TextStyle(fontFamily: _kFontFamily),
  overline: TextStyle(fontFamily: _kFontFamily),
);

const _kDefaultTextStyle = TextStyle(
  fontFamily: _kFontFamily,
  fontFamilyFallback: _kFontFallbacks,
  overflow: TextOverflow.fade,
);

/// A [TextTheme] derived form [_kPicassoFontFamilyTextTheme] with proper
/// font sizes, spacing and baselines defined
final kPicassoDefaultTextTheme = _kPicassoFontFamilyTextTheme.copyWith(
  headline1: _kDefaultTextStyle.copyWith(
    fontSize: 40,
    height: 1.2,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0,
  ),
  headline2: _kDefaultTextStyle.copyWith(
    fontSize: 32,
    height: 1.125,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0,
  ),
  headline3: _kDefaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 1.143,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0,
  ),
  headline4: _kDefaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.333,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0,
  ),
  headline5: _kDefaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.2,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0,
  ),
  headline6: _kDefaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.333,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0,
  ),
  subtitle1: _kDefaultTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.2,
  ),
  subtitle2: _kDefaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.428,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.2,
  ),
  bodyText1: _kDefaultTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.2,
  ),
  bodyText2: _kDefaultTextStyle.copyWith(
    fontSize: 14,
    height: 1.428,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.2,
  ),
  button: _kDefaultTextStyle.copyWith(
    fontSize: 14,
    height: 1.428,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.2,
  ),
  caption: _kDefaultTextStyle.copyWith(
    fontSize: 12,
    height: 1.333,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.2,
  ),
  overline: _kDefaultTextStyle.copyWith(
    fontSize: 14,
    height: 1.428,
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 1,
  ),
);

/// A [TextTheme] derived from [kPicassoDefaultTextTheme] that has a
/// [TextBaseline.ideographic] as baseline
final kPicassoDenseTextTheme = const TextTheme(
  headline1: TextStyle(textBaseline: TextBaseline.ideographic),
  headline2: TextStyle(textBaseline: TextBaseline.ideographic),
  headline3: TextStyle(textBaseline: TextBaseline.ideographic),
  headline4: TextStyle(textBaseline: TextBaseline.ideographic),
  headline5: TextStyle(textBaseline: TextBaseline.ideographic),
  headline6: TextStyle(textBaseline: TextBaseline.ideographic),
  bodyText1: TextStyle(textBaseline: TextBaseline.ideographic),
  bodyText2: TextStyle(textBaseline: TextBaseline.ideographic),
  subtitle1: TextStyle(textBaseline: TextBaseline.ideographic),
  subtitle2: TextStyle(textBaseline: TextBaseline.ideographic),
  caption: TextStyle(textBaseline: TextBaseline.ideographic),
  button: TextStyle(textBaseline: TextBaseline.ideographic),
  overline: TextStyle(textBaseline: TextBaseline.ideographic),
).merge(kPicassoDefaultTextTheme);

/// A [Typography] defining [TargetPlatform.ios] as platform
final _a = Typography.material2018(
  platform: TargetPlatform.iOS,
);

/// A [Typography] that uses white and black from [_a] and
/// [kPicassoDefaultTextTheme]
///
/// It includes all the default font related dimensions.
Typography generateTypography(PicassoPaletteBase picassoPaletteBase) {
  final defaultTextTheme = kPicassoDefaultTextTheme.apply(
    bodyColor: picassoPaletteBase.text.primary,
    displayColor: picassoPaletteBase.text.primary,
  );
  final denseTextTheme = kPicassoDenseTextTheme.apply(
    bodyColor: picassoPaletteBase.text.primary,
    displayColor: picassoPaletteBase.text.primary,
  );
  return Typography.material2018(
    englishLike: defaultTextTheme,
    dense: denseTextTheme,
    white: _a.white.merge(_kPicassoFontFamilyTextTheme).apply(
          decorationColor: picassoPaletteBase.grey.shade700,
        ),
    black: _a.black.merge(_kPicassoFontFamilyTextTheme).apply(
          decorationColor: picassoPaletteBase.primary.main,
        ),
  );
}
