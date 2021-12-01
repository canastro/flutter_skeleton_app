import 'package:flutter/material.dart';

import '../../widgets/spacing.dart';
import '../palette.dart';

ElevatedButtonThemeData generateElevateButtonTheme(
  BanksyUiPaletteBase palette,
) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return palette.grey.shade200;
        }
        return palette.primary.main;
      }),
      visualDensity: const VisualDensity(),
      elevation: MaterialStateProperty.all(0.0),
      shape: MaterialStateProperty.all(
        const BeveledRectangleBorder(),
      ),
      minimumSize: MaterialStateProperty.all(
        Size(applySpacing(8.0), applySpacing(5.0)),
      ),
      animationDuration: kThemeAnimationDuration,
    ),
  );
}

OutlinedButtonThemeData generateOutlinedButtonTheme(
  BanksyUiPaletteBase palette,
) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(palette.transparent),
      visualDensity: const VisualDensity(),
      elevation: MaterialStateProperty.all(0.0),
      shape: MaterialStateProperty.all(
        const BeveledRectangleBorder(),
      ),
      minimumSize: MaterialStateProperty.all(
        Size(applySpacing(8.0), applySpacing(5.0)),
      ),
      animationDuration: kThemeAnimationDuration,
    ),
  );
}

TextButtonThemeData generateTextButtonTheme(BanksyUiPaletteBase palette) {
  return TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      backgroundColor: MaterialStateProperty.all(palette.transparent),
      shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
      minimumSize: MaterialStateProperty.all(
        Size(applySpacing(8.0), applySpacing(5.0)),
      ),
    ),
  );
}
