part of '../modifiable.dart';

extension ModifyThemeExtension on Modifier {
  Modifier textStyle({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    // addModifiable(
    //   SimpleModifiable(
    //     builder: (child) {
    //       return DefaultTextStyle(
    //         style: TextStyle(
    //           inherit: inherit,
    //           color: color,
    //           backgroundColor: backgroundColor,
    //           fontSize: fontSize,
    //           fontWeight: fontWeight,
    //           fontStyle: fontStyle,
    //           letterSpacing: letterSpacing,
    //           wordSpacing: wordSpacing,
    //           textBaseline: textBaseline,
    //           height: height,
    //           leadingDistribution: leadingDistribution,
    //           locale: locale,
    //           foreground: foreground,
    //           background: background,
    //           shadows: shadows,
    //           fontFeatures: fontFeatures,
    //           fontVariations: fontVariations,
    //           decoration: decoration,
    //           decorationColor: decorationColor,
    //           decorationStyle: decorationStyle,
    //           decorationThickness: decorationThickness,
    //           debugLabel: debugLabel,
    //           fontFamily: fontFamily,
    //           fontFamilyFallback: fontFamilyFallback,
    //           package: package,
    //           overflow: overflow,
    //         ),
    //         child: child,
    //       );
    //     },
    //   ),
    // );

    return this;
  }
}
