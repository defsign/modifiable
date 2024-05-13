part of '../modifiable.dart';

class InsetsModifiable extends ModifiableBase {
  InsetsModifiable({required this.insets});
  final EdgeInsetsGeometry insets;

  @override
  Widget build(BuildContext context, Widget child) {
    return Padding(padding: insets, child: child);
  }
}

extension ModifyInsetsExtension<T extends Modifier> on Modifier<T> {
  T padding(EdgeInsetsGeometry padding) => _setInsets(padding);

  /// Adds an inset of `value` on all the sides of its child.
  T paddingAll(double value) => _setInsets(EdgeInsets.all(value));

  /// Adds insets of `value` on the x-axis of its child.
  T paddingX(double value) =>
      _setInsets(EdgeInsets.symmetric(horizontal: value));

  /// Adds insets of `value` on the y-axis of its child.
  T paddingY(double value) => _setInsets(EdgeInsets.symmetric(vertical: value));

  /// Adds an inset of `value` at the left of its child.
  T paddingLeft(double value) => _setInsets(EdgeInsets.only(left: value));

  /// Adds an inset of `value` at the right of its child.
  T paddingRight(double value) => _setInsets(EdgeInsets.only(right: value));

  /// Adds an inset of `value` at the start of its child.
  T paddingStart(double value) =>
      _setInsets(EdgeInsetsDirectional.only(start: value));

  /// Adds an inset of `value` at the end of its child.
  T paddingEnd(double value) =>
      _setInsets(EdgeInsetsDirectional.only(end: value));

  /// Adds an inset of `value` at the top of its child.
  T paddingTop(double value) => _setInsets(EdgeInsets.only(top: value));

  /// Adds an inset of `value` at the bottom of its child.
  T paddingBottom(double value) => _setInsets(EdgeInsets.only(bottom: value));

  /// Adds insets from the left, top, right, and bottom of its child.
  T paddingFromLTRB(double left, double top, double right, double bottom) =>
      _setInsets(EdgeInsets.fromLTRB(left, top, right, bottom));

  /// Adds insets from the start, top, end, and bottom of its child.
  T paddingFromSTEB(double start, double top, double end, double bottom) =>
      _setInsets(EdgeInsetsDirectional.fromSTEB(start, top, end, bottom));

  T _setInsets(EdgeInsetsGeometry insets) {
    return addModifiable(InsetsModifiable(insets: insets));
  }
}
