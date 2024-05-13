part of '../modifiable.dart';

class SizedBuildable extends BuildableModifiable {
  SizedBuildable({required super.builder});
}

extension ModifySizeExtension<T extends Modifier> on Modifier<T> {
  /// Wraps its child with a box that becomes as large as the parent will allow it.
  T expand() => _setSize(width: double.maxFinite, height: double.maxFinite);

  /// Wraps its child with a box that will become as small as its parent allows.
  T shrink() => _setSize(width: 0, height: 0);

  /// Wraps its child with a box whose width and height are equal.
  T square(double dimension) => _setSize(width: dimension, height: dimension);

  /// Wraps its child with a fixed size box.
  T size(double width, double height) => _setSize(width: width, height: height);

  /// Wraps its child with a box with width as `value`.
  T width(double value) => _setSize(width: value);

  /// Wraps its child with a box with height as `value`.
  T height(double height) => _setSize(height: height);

  /// Wraps its child with a box whose width is set to the maximum
  /// width allowed by the parent. The `widthFactor` determines how
  /// much width is used by the child.
  T maxWidth([double widthFactor = 1]) =>
      _setSize(maxWidth: true, widthFactor: widthFactor);

  /// Wraps its child with a box whose height is set `height` and
  /// its width is set to the maximum width allowed by its parent.
  /// The `widthFactor` determines how much of the width is used
  /// by the child.
  T heightAndMaxWidth(double height, [double widthFactor = 1]) =>
      _setSize(maxWidth: true, widthFactor: widthFactor, height: height);

  /// Wraps its child with a box whose width is set `width` and
  /// its height is set to the maximum height allowed by its parent.
  /// The `heightFactor` determines how much of the height is used
  /// by the child.
  T widthAndMaxHeight(double width, [double heightFactor = 1]) =>
      _setSize(maxHeight: true, heightFactor: heightFactor, width: width);

  /// Wraps its child with a box whose height is set to the maximum
  /// width allowed by the parent. The `heightFactor` determines how
  /// much height is used by the child.
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
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final newWidth =
                maxWidth ? constraints.maxWidth * widthFactor : width;
            final newHeight =
                maxHeight ? constraints.maxHeight * heightFactor : height;
            return SizedBox(width: newWidth, height: newHeight, child: child);
          },
        );
      },
    );
    return addModifiable(modifiable);
  }
}
