import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'palette.dart';
import 'theme/theme.dart';

/// Defines general data for a banksy_ui context.
///
/// See also:
/// * [BanksyUiProvider] : Makes a [BanksyUiData] accessible in a subtree
class BanksyUiData {
  /// Access the [BanksyUiData] instance provided via [BanksyUiProvider].
  ///
  /// Throws an assertion error if there is no [BanksyUiProvider] up in the tree.
  ///
  /// It only reads the context, therefore it doesn't create dependency.
  static BanksyUiData of(BuildContext context) {
    final picassoProvider =
        context.findAncestorWidgetOfExactType<BanksyUiProvider>();
    assert(
      picassoProvider != null,
      'No banksy_ui instance found, this widget must be under a BanksyUiProvider',
    );
    return picassoProvider!.data;
  }

  /// Access the [ThemeData] instance provided under [MaterialApp].
  ///
  /// Keeping this under banksy_ui instead of calling [Theme.of] directly gives
  /// banksy_ui control of the theming and in a possible subclassing
  /// of [ThemeData]
  static ThemeData themeOf(BuildContext context) {
    return Theme.of(context);
  }

  /// Creates a banksy_ui data instance
  ///
  /// [palette] defaults to [BanksyUiPalette]
  BanksyUiData({
    BanksyUiPaletteBase? palette,
  }) : palette = palette ?? BanksyUiPalette();

  /// An underlying palette that will be used to generate themes
  ///
  /// By default it is an instance of [BanksyUiPalette]
  final BanksyUiPaletteBase palette;

  /// A lighter generated material [ThemeData] using colors from [palette]
  late final ThemeData materialLightTheme = generateThemeData(palette);

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
/// This makes [data] accessible for its descendants via [BanksyUiData.of].
class BanksyUiProvider extends InheritedWidget {
  const BanksyUiProvider({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  /// The data to be exposed for the descendants
  ///
  /// Accessible via [BanksyUiData.of].
  final BanksyUiData data;

  @override
  bool updateShouldNotify(BanksyUiProvider oldWidget) {
    // BanksyUi data should not be changed.
    assert(data == oldWidget.data);
    return false;
  }
}
