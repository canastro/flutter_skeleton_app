import 'package:flutter/widgets.dart';

/// How many pixels a spacing unit represents
const double kBanksyUiSpaceUnit = 8.0;

/// Converts a [multiplier] of spacing units to pixels
double applySpacing(num multiplier) => multiplier * kBanksyUiSpaceUnit;

/// A [StatelessWidget] that assumes a [multiplier] in spacing units in the
/// given [direction].
///
/// Commonly used under [Row], [Column] or [Flex] widgets
class Spacing extends StatelessWidget {
  /// The specified size in spacing units
  final double multiplier;

  /// The direction in which the widget will be sized with [multiplier]
  final Axis direction;

  /// Creates a [Spacing] instance with sane defaults
  const Spacing({
    Key? key,
    this.multiplier = 1.0,
    this.direction = Axis.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sized = Size(applySpacing(multiplier), 0);

    if (direction == Axis.horizontal) {
      return SizedBox.fromSize(
        size: sized,
      );
    }

    return SizedBox.fromSize(
      size: sized.flipped,
    );
  }
}
