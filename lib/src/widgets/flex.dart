part of '../modifiable.dart';

/// A modifiable that applies flexible constraints to its child.
///
/// The `FlexModifiable` widget wraps its child with a `Flexible` widget, allowing it to
/// expand and contract within a `Flex` container according to its `fit` and `flex` properties.
///
/// Parameters:
/// - [fit]: How the child should flex within its parent's constraints.
/// - [flex]: The flex factor to determine how much space the child should occupy relative
///           to other flexible children within the same `Flex` container.
class FlexModifiable extends ModifiableBase {
  /// Creates a `FlexModifiable` with the specified flex and fit properties.
  ///
  /// The [fit] parameter specifies how the child should flex within its parent's constraints,
  /// and the [flex] parameter determines the flex factor of the child.
  FlexModifiable({required this.fit, required this.flex});

  /// How the child should flex within its parent's constraints.
  final FlexFit fit;

  /// The flex factor to determine how much space the child should occupy.
  final int flex;

  @override
  Widget build(BuildContext context, Widget child) {
    return Flexible(fit: fit, flex: flex, child: child);
  }
}

/// Extension for modifying the flexibility of widgets within a flex container.
///
/// The `ModifyFlexExtension` extension provides methods for modifying the flexibility
/// of widgets within a flex container such as [Row], [Column], or [Flex]. These methods
/// allow you to control how the child widgets expand and flex within the available space
/// along the main axis of the flex container.
///
/// Parameters:
/// - [T]: The type of `Modifier` to which the extension applies.
extension ModifyFlexExtension<T extends Modifier> on Modifier<T> {
  /// Creates a modifier that expands a child within a flex container.
  ///
  /// The `expanded` method creates a modifier that wraps its child with a `Flexible` widget
  /// configured to expand the child to fill the available space along the flex container's
  /// main axis. The [flex] parameter specifies the flex factor, determining how much
  /// space the child should occupy relative to other flexible children within the same
  /// flex container.
  ///
  /// Parameters:
  /// - [flex]: The flex factor to determine how much space the child should occupy.
  ///           Default value is 1.
  ///
  /// Returns a modified `Modifier` instance with the child expanded within the flex container.
  Modifier expanded([int flex = 1]) => _setFlex(FlexFit.tight, flex);

  /// Creates a modifier that controls how a child flexes within a flex container.
  ///
  /// The `flexible` method creates a modifier that wraps its child with a `Flexible` widget
  /// configured to control how the child flexes within the available space along the flex
  /// container's main axis. The [flex] parameter specifies the flex factor, determining how
  /// much space the child should occupy relative to other flexible children within the same
  /// flex container, and the [fit] parameter specifies how the child should flex.
  ///
  /// Parameters:
  /// - [flex]: The flex factor to determine how much space the child should occupy.
  ///           Default value is 1.
  /// - [fit]: How the child should flex within its parent's constraints. Default is `FlexFit.loose`.
  ///
  /// Returns a modified `Modifier` instance with the child flexibly positioned within the flex container.
  Modifier flexible([int flex = 1, FlexFit fit = FlexFit.loose]) =>
      _setFlex(fit, flex);

  Modifier _setFlex(FlexFit fit, int flex) =>
      addModifiable(FlexModifiable(fit: fit, flex: flex));
}
