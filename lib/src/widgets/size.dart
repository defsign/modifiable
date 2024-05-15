part of '../modifiable.dart';

/// A modifiable that wraps its child with a `SizedBox` with dynamic size constraints.
///
/// The `SizedBuildable` widget is used to modify the size of its child widget by wrapping it with a `SizedBox`.
/// It allows setting dynamic size constraints based on the parent's layout using factors or absolute values.
///
/// By specifying [width] and/or [height], you can set absolute dimensions for the `SizedBox`.
/// Alternatively, you can set [maxWidth] or [maxHeight] to true along with [widthFactor] or [heightFactor]
/// to use the parent's maximum width or height as constraints, scaled by the respective factors.
///
/// Example usage:
/// ```dart
/// SizedBuildable(
///   width: 100, // Set an absolute width of 100 pixels
///   height: 150, // Set an absolute height of 150 pixels
/// )
/// ```
class SizedBuildable extends BuildableModifiable {
  SizedBuildable({
    double? width,
    double? height,
    double widthFactor = 1,
    double heightFactor = 1,
    bool maxWidth = false,
    bool maxHeight = false,
  }) : super(
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final newWidth =
                    maxWidth ? constraints.maxWidth * widthFactor : width;
                final newHeight =
                    maxHeight ? constraints.maxHeight * heightFactor : height;
                return SizedBox(
                    width: newWidth, height: newHeight, child: child);
              },
            );
          },
        );
}

/// Extension for modifying the size of widgets.
///
/// The `ModifySizeExtension` extension provides methods for modifying the size of widgets
/// by applying constraints such as width, height, maximum width, maximum height, and more.
/// These methods can be chained together to create complex size modifications.
///
/// Parameters:
/// - [T]: The type of `Modifier` to which the extension applies.
extension ModifySizeExtension<T extends Modifier> on Modifier<T> {
  /// Expands the size of the widget to fill the available space in its parent widget.
  ///
  /// The `expand` method wraps the child widget with a `SizedBox` widget that expands to fill
  /// the available space in its parent widget.
  ///
  /// Returns a modified `Modifier` instance with the expanded size applied.
  T expand() => _setSize(maxWidth: true, maxHeight: true);

  /// Shrinks the size of the widget to its minimum allowed size within its parent widget.
  ///
  /// The `shrink` method wraps the child widget with a `SizedBox` widget that shrinks to its
  /// minimum allowed size within its parent widget. It sets the width and height of the `SizedBox`
  /// to 0, effectively reducing the size of the widget to the minimum.
  ///
  /// Returns a modified `Modifier` instance with the shrunk size applied.
  T shrink() => _setSize(width: 0, height: 0);

  /// Sets the size of the widget to a square with the specified dimension.
  ///
  /// The `square` method wraps the child widget with a `SizedBox` widget that sets both the
  /// width and height to the specified `dimension`, resulting in a square widget.
  ///
  /// Parameters:
  /// - [dimension]: The size of the square in both width and height.
  ///
  /// Returns a modified `Modifier` instance with the square size applied.
  T square(double dimension) => _setSize(width: dimension, height: dimension);

  /// Sets the size of the widget to the specified width and height.
  ///
  /// The `size` method wraps the child widget with a `SizedBox` widget that sets the width
  /// and height to the specified `width` and `height` parameters.
  ///
  /// Parameters:
  /// - [width]: The width of the widget.
  /// - [height]: The height of the widget.
  ///
  /// Returns a modified `Modifier` instance with the specified size applied.
  T size(double width, double height) => _setSize(width: width, height: height);

  /// Sets the width of the widget to the specified value.
  ///
  /// The `width` method wraps the child widget with a `SizedBox` widget that sets the width
  /// to the specified `value` parameter while maintaining its original height.
  ///
  /// Parameters:
  /// - [value]: The width of the widget.
  ///
  /// Returns a modified `Modifier` instance with the specified width applied.
  T width(double value) => _setSize(width: value);

  /// Sets the height of the widget to the specified value.
  ///
  /// The `height` method wraps the child widget with a `SizedBox` widget that sets the height
  /// to the specified `height` parameter while maintaining its original width.
  ///
  /// Parameters:
  /// - [height]: The height of the widget.
  ///
  /// Returns a modified `Modifier` instance with the specified height applied.
  T height(double height) => _setSize(height: height);

  /// Sets the width of the widget to the maximum width allowed by its parent widget.
  ///
  /// The `maxWidth` method wraps the child widget with a `SizedBox` widget that sets the width
  /// to the maximum width allowed by its parent widget. Optionally, you can specify a [widthFactor]
  /// to determine how much of the parent's maximum width should be used by the child.
  ///
  /// Parameters:
  /// - [widthFactor]: The fraction of the parent's maximum width used by the child. Default is 1.
  ///
  /// Returns a modified `Modifier` instance with the specified width applied.
  T maxWidth([double widthFactor = 1]) =>
      _setSize(maxWidth: true, widthFactor: widthFactor);

  /// Sets the width of the widget to the maximum width allowed by its parent widget and specifies a fixed height.
  ///
  /// The `heightAndMaxWidth` method wraps the child widget with a `SizedBox` widget that sets the width
  /// to the maximum width allowed by its parent widget and the height to the specified `height` parameter.
  /// Additionally, you can specify a [widthFactor] to determine how much of the parent's maximum width
  /// should be used by the child.
  ///
  /// Parameters:
  /// - [height]: The fixed height of the widget.
  /// - [widthFactor]: The fraction of the parent's maximum width used by the child. Default is 1.
  ///
  /// Returns a modified `Modifier` instance with the specified width and height applied.
  T heightAndMaxWidth(double height, [double widthFactor = 1]) =>
      _setSize(maxWidth: true, widthFactor: widthFactor, height: height);

  /// Sets the height of the widget to the maximum height allowed by its parent widget and specifies a fixed width.
  ///
  /// The `widthAndMaxHeight` method wraps the child widget with a `SizedBox` widget that sets the height
  /// to the maximum height allowed by its parent widget and the width to the specified `width` parameter.
  /// Additionally, you can specify a [heightFactor] to determine how much of the parent's maximum height
  /// should be used by the child.
  ///
  /// Parameters:
  /// - [width]: The fixed width of the widget.
  /// - [heightFactor]: The fraction of the parent's maximum height used by the child. Default is 1.
  ///
  /// Returns a modified `Modifier` instance with the specified width and height applied.
  T widthAndMaxHeight(double width, [double heightFactor = 1]) =>
      _setSize(maxHeight: true, heightFactor: heightFactor, width: width);

  /// Sets the height of the widget to the maximum height allowed by its parent widget.
  ///
  /// The `maxHeight` method wraps the child widget with a `SizedBox` widget that sets the height
  /// to the maximum height allowed by its parent widget. Optionally, you can specify a [heightFactor]
  /// to determine how much of the parent's maximum height should be used by the child.
  ///
  /// Parameters:
  /// - [heightFactor]: The fraction of the parent's maximum height used by the child. Default is 1.
  ///
  /// Returns a modified `Modifier` instance with the specified height applied.
  T maxHeight([double heightFactor = 1]) =>
      _setSize(maxHeight: true, heightFactor: heightFactor);

  T _setSize({
    double? width,
    double? height,
    double widthFactor = 1,
    double heightFactor = 1,
    bool maxWidth = false,
    bool maxHeight = false,
  }) {
    final modifiable = SizedBuildable(
      width: width,
      widthFactor: widthFactor,
      maxWidth: maxWidth,
      height: height,
      heightFactor: heightFactor,
      maxHeight: maxHeight,
    );
    return addModifiable(modifiable);
  }
}
