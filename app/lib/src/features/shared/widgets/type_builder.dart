import 'package:flutter/widgets.dart';

/// Buildes a wiget for a [TypeBuilderFactory]
typedef TypeWidgetBuilder<T> = Widget Function(BuildContext context, T value);

/// Represents a type entry to [TypeBuilder].
class TypeBuilderFactory<T> {
  final TypeWidgetBuilder<T> typeWidgetBuilder;

  TypeBuilderFactory(this.typeWidgetBuilder);

  bool _debugAssertTypeMatches(Type type) {
    assert(
      type == T,
      'TypeBuilderFactory of type $T was used where type $type was specified.',
    );
    return true;
  }

  Widget call(BuildContext context, dynamic value) {
    return typeWidgetBuilder(context, value as T);
  }
}

/// A [StatelessWidget] that renders a specific widget subtree for each possible
/// type of [value].
///
/// It is useful for rendering different widgets for a value that can assume
/// subtypes given different conditions.
///
/// Usage example
/// ```dart
/// abstract class Tans {}
///
/// class TansValue extends Tans {}
///
/// class TansLoading extends Tans {}
///
/// final a = TypeBuilder<Tans>(
///   value: TansValue(),
///   typeBuilders: {
///     TansValue: TypeBuilderFactory<TansValue>((context, value) {
///       return const Text('Lol value');
///     }),
///     TansLoading: TypeBuilderFactory<TansLoading>((context, value) {
///       return const Text('Lol loading');
///     }),
///   },
/// );
/// ```
class TypeBuilder<MasterType> extends StatelessWidget {
  final Map<Type, TypeBuilderFactory> typeBuilders;
  final MasterType value;
  final TypeWidgetBuilder<MasterType> defaultBuilder;

  const TypeBuilder({
    Key? key,
    required this.value,
    required this.typeBuilders,
    required this.defaultBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(
      () {
        for (final type in typeBuilders.keys) {
          assert(typeBuilders[type]!._debugAssertTypeMatches(type));
        }
        return true;
      }(),
    );

    for (final entry in typeBuilders.entries) {
      final type = entry.key;

      if (value.runtimeType == type) {
        return entry.value(context, value);
      }
    }
    return defaultBuilder(context, value);
  }
}
