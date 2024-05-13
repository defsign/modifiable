part of '../modifiable.dart';

class FlexModifiable extends ModifiableBase {
  FlexModifiable({required this.fit, required this.flex});

  final FlexFit fit;

  final int flex;

  @override
  Widget build(BuildContext context, Widget child) {
    return Flexible(fit: fit, flex: flex, child: child);
  }
}

extension ModifyFlexExtension<T extends Modifier> on Modifier<T> {
  /// Creates a widget that expands a child of a [Row], [Column], or [Flex]
  /// so that the child fills the available space along the flex widget's
  /// main axis.
  Modifier expanded([int flex = 1]) => _setFlex(FlexFit.tight, flex);

  /// Creates a widget that controls how a child of a [Row], [Column], or [Flex]
  /// flexes.
  Modifier flexible([int flex = 1, FlexFit fit = FlexFit.loose]) =>
      _setFlex(fit, flex);

  Modifier _setFlex(FlexFit fit, int flex) =>
      addModifiable(FlexModifiable(fit: fit, flex: flex));
}
