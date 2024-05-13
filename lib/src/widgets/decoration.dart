part of '../modifiable.dart';

class DecorationModifiable extends BuildableModifiable {
  DecorationModifiable({required this.decoration, required super.builder});
  final Decoration decoration;

  DecorationModifiable copyWith({BoxDecoration? decoration}) {
    return DecorationModifiable(
      builder: builder,
      decoration: decoration ?? this.decoration,
    );
  }
}

extension DecorationModifyExtension<T extends Modifier> on Modifier<T> {
  T decorationImage(
    String url, {
    Map<String, String>? headers,
    void Function(Object, StackTrace?)? onError,
    ColorFilter? colorFilter,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    Rect? centerSlice,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
    double scale = 1.0,
    double opacity = 1.0,
    FilterQuality filterQuality = FilterQuality.low,
    bool invertColors = false,
    bool isAntiAlias = false,
  }) =>
      _setDecoration(
        image: DecorationImage(
          image: NetworkImage(url, headers: headers),
          alignment: alignment,
          centerSlice: centerSlice,
          colorFilter: colorFilter,
          filterQuality: filterQuality,
          fit: fit,
          invertColors: invertColors,
          isAntiAlias: isAntiAlias,
          matchTextDirection: matchTextDirection,
          onError: onError,
          opacity: opacity,
          repeat: repeat,
          scale: scale,
        ),
      );

  T backgroundColor(Color color) => _setDecoration(color: color);

  T gradient(Gradient gradient) => _setDecoration(gradient: gradient);

  T backgroundBlendMode(BlendMode backgroundBlendMode) =>
      _setDecoration(backgroundBlendMode: backgroundBlendMode);

  T shape(BoxShape shape, [Clip clip = Clip.none]) =>
      _setDecoration(shape: shape, clipBehavior: clip);

  T foregroundShape(BoxShape shape) =>
      _setDecoration(shape: shape, position: DecorationPosition.foreground);

  T boxShadow(BoxShape shape) => _setDecoration(shape: shape);

  T border(
    Border border, {
    BorderRadius? borderRadius,
    Clip clipBehavior = Clip.none,
  }) =>
      _setDecoration(
        border: border,
        borderRadius: borderRadius,
        clipBehavior: clipBehavior,
      );

  T borderAll({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    double strokeAlign = BorderSide.strokeAlignInside,
    BorderRadius? borderRadius,
    Clip clipBehavior = Clip.none,
  }) =>
      _setDecoration(
        border: Border.all(
          color: color,
          strokeAlign: strokeAlign,
          style: style,
          width: width,
        ),
        borderRadius: borderRadius,
        clipBehavior: clipBehavior,
      );

  T borderRadius(
    BorderRadius borderRadius, [
    Clip clipBehavior = Clip.antiAlias,
  ]) =>
      _setDecoration(
        borderRadius: borderRadius,
        clipBehavior: clipBehavior,
      );

  T clipCircularRRect(
    double radius, [
    Clip clipBehavior = Clip.antiAlias,
  ]) =>
      _setDecoration(
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: clipBehavior,
      );

  T circularBorderRadius(
    double radius, [
    Clip clipBehavior = Clip.antiAlias,
  ]) =>
      _setDecoration(
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: clipBehavior,
      );

  T foregroundBorder(
    Border border, {
    BorderRadius? borderRadius,
    Clip clipBehavior = Clip.none,
  }) =>
      _setDecoration(
        border: border,
        borderRadius: borderRadius,
        position: DecorationPosition.foreground,
        clipBehavior: clipBehavior,
      );

  T foregroundBorderRadius(
    BorderRadius borderRadius, [
    Clip clipBehavior = Clip.antiAlias,
  ]) =>
      _setDecoration(
          borderRadius: borderRadius,
          clipBehavior: clipBehavior,
          position: DecorationPosition.foreground);

  T _setDecoration({
    List<BoxShadow>? boxShadow,
    DecorationImage? image,
    BoxBorder? border,
    Color? color,
    BoxShape? shape,
    Gradient? gradient,
    DecorationPosition? position,
    BlendMode? backgroundBlendMode,
    BorderRadiusGeometry? borderRadius,
    Clip clipBehavior = Clip.none,
  }) {
    final decoration = BoxDecoration(
      border: border,
      color: color,
      image: image,
      gradient: gradient,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      shape: shape ?? BoxShape.rectangle,
      backgroundBlendMode: backgroundBlendMode,
    );

    final modifiable = DecorationModifiable(
      decoration: decoration,
      builder: (context, child) {
        Widget current = child;

        if (clipBehavior != Clip.none) {
          current = ClipPath(
            clipBehavior: clipBehavior,
            clipper: _DecorationClipper(
              textDirection: Directionality.maybeOf(context),
              decoration: decoration,
            ),
            child: current,
          );
        }

        return DecoratedBox(
          position: position ?? DecorationPosition.background,
          decoration: decoration,
          child: Padding(
            padding: decoration.padding,
            child: current,
          ),
        );
      },
    );

    return addModifiable(modifiable);
  }
}

/// A clipper that uses [Decoration.getClipPath] to clip.
class _DecorationClipper extends CustomClipper<Path> {
  _DecorationClipper({
    TextDirection? textDirection,
    required this.decoration,
  }) : textDirection = textDirection ?? TextDirection.ltr;

  final TextDirection textDirection;
  final Decoration decoration;

  @override
  Path getClip(Size size) {
    return decoration.getClipPath(Offset.zero & size, textDirection);
  }

  @override
  bool shouldReclip(_DecorationClipper oldClipper) {
    return oldClipper.decoration != decoration ||
        oldClipper.textDirection != textDirection;
  }
}
