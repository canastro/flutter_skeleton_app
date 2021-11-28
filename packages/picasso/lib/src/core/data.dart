import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'palette.dart';
import 'theme/theme.dart';

/// Defines general data for a picasso context.
///
/// See also:
/// * [PicassoProvider] : Makes a [PicassoData] accessible in a subtree
class PicassoData {
  /// Access the [PicassoData] instance provided via [PicassoProvider].
  ///
  /// Throws an assertion error if there is no [PicassoProvider] up in the tree.
  ///
  /// It only reads the context, therefore it doesn't create dependency.
  static PicassoData of(BuildContext context) {
    final picassoProvider =
        context.findAncestorWidgetOfExactType<PicassoProvider>();
    assert(
      picassoProvider != null,
      'No picasso instance found, this widget must be under a PicassoProvider',
    );
    return picassoProvider!.data;
  }

  /// Access the [ThemeData] instance provided under [MaterialApp].
  ///
  /// Keeping this under picasso instead of calling [Theme.of] directly gives
  /// picasso control of the theming and in a possible subclassing
  /// of [ThemeData]
  static ThemeData themeOf(BuildContext context) {
    return Theme.of(context);
  }

  /// Creates a picasso data instance
  ///
  /// [palette] defaults to [PicassoPalette]
  PicassoData({
    PicassoPaletteBase? palette,
  }) : palette = palette ?? PicassoPalette();

  /// An underlying palette that will be used to generate themes
  ///
  /// By default it is an instance of [PicassoPalette]
  final PicassoPaletteBase palette;

  /// A lighter generated material [ThemeData] using colors from [palette]
  late final ThemeData materialLightTheme = generateThemeData(palette);

  /// A material theme for parts of a picasso app that uses an alternate theme,
  /// It uses [PicassoPalette.lily] as main background shade
  late final ThemeData alternateMaterialLightTheme =
      materialLightTheme.copyWith(
    colorScheme: materialLightTheme.colorScheme.copyWith(
      background: palette.lily.shade500,
      surface: palette.lily.shade500,
    ),
    canvasColor: palette.lily.shade500,
    scaffoldBackgroundColor: palette.lily.shade500,
  );

  /// A [CupertinoThemeData] to defines colors from the [palette] on cupertino
  /// Flutter elements
  late final CupertinoThemeData cupertinoLightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: palette.primary.main,
    primaryContrastingColor: palette.primary.contrast,
    scaffoldBackgroundColor: palette.white,
    barBackgroundColor: palette.grey.shade100,
  );
}

/// A [InheritedWidget] that makes [data] accessible for its descendants
///
/// Usually set on the very top of the widget tree.
///
/// This makes [data] accessible for its descendants via [PicassoData.of].
class PicassoProvider extends InheritedWidget {
  const PicassoProvider({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  /// The data to be exposed for the descendants
  ///
  /// Accessible via [PicassoData.of].
  final PicassoData data;

  @override
  bool updateShouldNotify(PicassoProvider oldWidget) {
    // Picasso data should not be changed.
    assert(data == oldWidget.data);
    return false;
  }
}
