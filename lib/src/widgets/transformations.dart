part of '../modifiable.dart';

class TransformationBuildable extends BuildableModifiable {
  TransformationBuildable({required super.builder});
}

extension ModifyTransformationsExtension<T extends Modifier> on Modifier<T> {
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

  /// Wraps its child with a widget that transforms its child using a rotation around the
  /// center.
  ///
  /// The `angle` argument gives the rotation in clockwise radians.
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

  /// Creates a widget that transforms its child using a translation.
  ///
  /// `x` and `y` arguments specifies the translation.
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

  T scaleXY(
    double scaleY,
    double scaleX, {
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
      Transform.scale(scaleY: scaleY, scaleX: scaleX).transform,
    );
  }

  /// Creates a widget that scales its child along the 2D plane.
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
    return addModifiable(modifiable);
  }
}
