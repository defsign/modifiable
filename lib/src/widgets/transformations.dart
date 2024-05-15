part of '../modifiable.dart';

/// A modifiable that applies a transformation to its child using a `Transform` widget.
///
/// The `TransformationBuildable` widget allows you to apply a 2D or 3D transformation to its child widget.
/// It extends the `BuildableModifiable` class, providing a convenient way to create and apply transformations
/// using a `Matrix4` transform matrix.
class TransformationBuildable extends BuildableModifiable {
  /// Constructs a `TransformationBuildable` widget with the specified parameters.
  ///
  /// The [transform] parameter is a `Matrix4` transform matrix that defines the transformation to apply to the child widget.
  /// The [origin] parameter specifies the origin point for the transformation. If null, the center of the widget is used as the origin.
  /// The [transformHitTests] parameter indicates whether hit tests should be transformed along with the widget. Default is true.
  /// The [alignment] parameter specifies how the child should be aligned within the transformed space. Default is Alignment.center.
  /// The [filterQuality] parameter specifies the filter quality for the transformation. Default is FilterQuality.low.
  TransformationBuildable(
    Matrix4 transform, {
    Offset? origin,
    bool transformHitTests = true,
    AlignmentGeometry? alignment,
    FilterQuality? filterQuality,
  }) : super(
          builder: (context, child) {
            return Transform(
              transform: transform,
              origin: origin,
              alignment: alignment,
              filterQuality: filterQuality,
              transformHitTests: transformHitTests,
              child: child,
            );
          },
        );
}

/// An extension on the `Modifier` class to apply transformations to widgets.
///
/// The `ModifyTransformationsExtension` extension allows you to apply transformations to widgets
/// by chaining the `transform` method with a `Matrix4` transform matrix.
extension ModifyTransformationsExtension<T extends Modifier> on Modifier<T> {
  /// Applies a transformation to the widget.
  ///
  /// The [transform] parameter is a `Matrix4` transform matrix that defines the transformation to apply to the widget.
  /// The [origin] parameter specifies the origin point for the transformation. If null, the center of the widget is used as the origin.
  /// The [alignment] parameter specifies how the child should be aligned within the transformed space. Default is Alignment.center.
  /// The [transformHitTests] parameter indicates whether hit tests should be transformed along with the widget. Default is true.
  /// The [filterQuality] parameter specifies the filter quality for the transformation. Default is FilterQuality.low.
  ///
  /// Returns a modified `Modifier` instance with the transformation applied.
  T transform(
    Matrix4 transform, {
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
  }) {
    return _setTransform(
      transform,
      origin: origin,
      alignment: alignment,
      filterQuality: filterQuality,
      transformHitTests: transformHitTests,
    );
  }

  /// Rotates the widget by the specified angle.
  ///
  /// The [angle] parameter specifies the angle of rotation in radians.
  /// The [origin] parameter specifies the origin point for the rotation. If null, the center of the widget is used as the origin.
  /// The [alignment] parameter specifies how the child should be aligned within the rotated space. Default is Alignment.center.
  /// The [transformHitTests] parameter indicates whether hit tests should be transformed along with the widget. Default is true.
  /// The [filterQuality] parameter specifies the filter quality for the transformation. Default is FilterQuality.low.
  ///
  /// Returns a modified `Modifier` instance with the rotation applied.
  T rotate(
    double angle, {
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
  }) {
    return _setTransform(
      origin: origin,
      alignment: alignment,
      filterQuality: filterQuality,
      transformHitTests: transformHitTests,
      Transform.rotate(angle: angle).transform,
    );
  }

  /// Translates the widget by the specified offsets along the x and y axes.
  ///
  /// The [x] parameter specifies the offset along the x-axis.
  /// The [y] parameter specifies the offset along the y-axis.
  /// The [origin] parameter specifies the origin point for the translation. If null, the center of the widget is used as the origin.
  /// The [alignment] parameter specifies how the child should be aligned within the translated space. Default is Alignment.center.
  /// The [transformHitTests] parameter indicates whether hit tests should be transformed along with the widget. Default is true.
  /// The [filterQuality] parameter specifies the filter quality for the transformation. Default is FilterQuality.low.
  ///
  /// Returns a modified `Modifier` instance with the translation applied.
  T translate(
    double x,
    double y, {
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
  }) {
    return _setTransform(
      origin: origin,
      alignment: alignment,
      filterQuality: filterQuality,
      transformHitTests: transformHitTests,
      Transform.translate(offset: Offset(x, y)).transform,
    );
  }

  /// Scales the widget along the x-axis by the specified factor.
  ///
  /// The [scaleX] parameter specifies the scaling factor along the x-axis.
  /// The [origin] parameter specifies the origin point for the scaling. If null, the center of the widget is used as the origin.
  /// The [alignment] parameter specifies how the child should be aligned within the scaled space. Default is Alignment.center.
  /// The [transformHitTests] parameter indicates whether hit tests should be transformed along with the widget. Default is true.
  /// The [filterQuality] parameter specifies the filter quality for the transformation. Default is FilterQuality.low.
  ///
  /// Returns a modified `Modifier` instance with the scaling applied.
  T scaleX(
    double scaleX, {
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
  }) {
    return _setTransform(
      origin: origin,
      alignment: alignment,
      filterQuality: filterQuality,
      transformHitTests: transformHitTests,
      Transform.scale(scaleX: scaleX).transform,
    );
  }

  /// Scales the widget along the y-axis by the specified factor.
  ///
  /// The [scaleY] parameter specifies the scaling factor along the y-axis.
  /// The [origin] parameter specifies the origin point for the scaling. If null, the center of the widget is used as the origin.
  /// The [alignment] parameter specifies how the child should be aligned within the scaled space. Default is Alignment.center.
  /// The [transformHitTests] parameter indicates whether hit tests should be transformed along with the widget. Default is true.
  /// The [filterQuality] parameter specifies the filter quality for the transformation. Default is FilterQuality.low.
  ///
  /// Returns a modified `Modifier` instance with the scaling applied.
  T scaleY(
    double scaleY, {
    AlignmentGeometry? alignment,
    Offset? origin,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
  }) {
    return _setTransform(
      origin: origin,
      alignment: alignment,
      filterQuality: filterQuality,
      transformHitTests: transformHitTests,
      Transform.scale(scaleY: scaleY).transform,
    );
  }

  /// Scales the widget uniformly by the specified factor.
  ///
  /// The [scale] parameter specifies the scaling factor for both the x-axis and y-axis.
  /// The [origin] parameter specifies the origin point for the scaling. If null, the center of the widget is used as the origin.
  /// The [alignment] parameter specifies how the child should be aligned within the scaled space. Default is Alignment.center.
  /// The [transformHitTests] parameter indicates whether hit tests should be transformed along with the widget. Default is true.
  /// The [filterQuality] parameter specifies the filter quality for the transformation. Default is FilterQuality.low.
  ///
  /// Returns a modified `Modifier` instance with the scaling applied.
  T scale(
    double scale, {
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
  }) {
    return _setTransform(
      origin: origin,
      alignment: alignment,
      filterQuality: filterQuality,
      transformHitTests: transformHitTests,
      Transform.scale(scale: scale).transform,
    );
  }

  T _setTransform(
    Matrix4 transform, {
    Offset? origin,
    bool transformHitTests = true,
    AlignmentGeometry? alignment,
    FilterQuality? filterQuality,
  }) {
    final modifiable = TransformationBuildable(
      transform,
      origin: origin,
      alignment: alignment,
      filterQuality: filterQuality,
      transformHitTests: transformHitTests,
    );
    return addModifiable(modifiable);
  }
}
