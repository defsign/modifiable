part of '../modifiable.dart';

class AlignmentModifiable extends BuildableModifiable {
  AlignmentModifiable({required super.builder});
}

extension ModifyAlignExtension<T extends Modifier> on Modifier<T> {
  T align(Alignment alignment) => _setAlignment(alignment);

  /// Aligns its child at the top left corner.
  T alignTopLeft() => _setAlignment(Alignment.topLeft);

  /// Aligns its child at the center point along the top edge.
  T alignTopCenter() => _setAlignment(AlignmentDirectional.topCenter);

  /// Aligns its child at the top right corner
  T alignTopRight() => _setAlignment(AlignmentDirectional.topEnd);

  /// Aligns its child at the center point along the left edge.
  T alignCenterLeft() => _setAlignment(Alignment.centerLeft);

  /// Aligns its child at the center point, both horizontally and vertically.
  T alignCenter() => _setAlignment(AlignmentDirectional.center);

  /// Aligns its child at the center point along the right edge.
  T alignCenterRight() => _setAlignment(Alignment.centerRight);

  /// Aligns its child at the bottom left corner.
  T alignBottomLeft() => _setAlignment(Alignment.bottomLeft);

  /// Aligns its child at the center point along the bottom edge.
  T alignBottomCenter() => _setAlignment(AlignmentDirectional.bottomCenter);

  /// Aligns its child at the bottom right corner.
  T alignBottomRight() => _setAlignment(Alignment.bottomRight);

  /// Aligns its child at the top corner on the "start" side.
  T alignTopStart() => _setAlignment(AlignmentDirectional.topStart);

  /// Aligns its child at the top corner on the "end" side.
  T alignTopEnd() => _setAlignment(AlignmentDirectional.topEnd);

  /// Aligns its child at the center point along the "start" edge.
  T alignCenterStart() => _setAlignment(AlignmentDirectional.centerStart);

  /// Aligns its child at the center point along the "end" edge.
  T alignCenterEnd() => _setAlignment(AlignmentDirectional.centerEnd);

  /// Aligns its child at the bottom corner on the "start" side.
  T alignBottomStart() => _setAlignment(AlignmentDirectional.bottomEnd);

  /// Aligns its child at the bottom corner on the "end" side.
  T alignBottomEnd() => _setAlignment(AlignmentDirectional.bottomEnd);

  T _setAlignment(AlignmentGeometry alignment) {
    final modifiable = AlignmentModifiable(
      builder: (context, child) {
        return Align(alignment: alignment, child: child);
      },
    );
    return addModifiable(modifiable);
  }
}
