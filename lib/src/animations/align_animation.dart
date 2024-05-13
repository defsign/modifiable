part of '../modifiable.dart';

extension ModifyAlignAnimationExtension<T extends Modifier> on Modifier<T> {
  Modifier animateFade({
    Curve? curve,
    double? end,
    double? begin,
    Duration? delay,
    Duration? duration,
  }) {
    return addEffect(
      FadeEffect(
        end: end,
        begin: begin,
        curve: curve,
        delay: delay,
        duration: duration,
      ),
    );
  }

  Modifier animateAlign({
    Curve? curve,
    Alignment? end,
    Alignment? begin,
    Duration? delay,
    Duration? duration,
  }) {
    return addEffect(
      AlignEffect(
        end: end,
        begin: begin,
        curve: curve,
        delay: delay,
        duration: duration,
      ),
    );
  }
}
