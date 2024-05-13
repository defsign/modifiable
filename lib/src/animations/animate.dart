part of '../modifiable.dart';

extension ModifyAnimateExtension<T extends Modifier> on Modifier<T> {
  Modifier animate({
    Key? key,
    List<Effect<dynamic>>? effects,
    void Function(AnimationController)? onInit,
    void Function(AnimationController)? onPlay,
    void Function(AnimationController)? onComplete,
    bool? autoPlay,
    Duration? delay,
    AnimationController? controller,
    Adapter? adapter,
    double? value,
    double? target,
  }) {
    return addModifiable(
      AnimateModifiable(
        key: key,
        delay: delay,
        value: value,
        onInit: onInit,
        onPlay: onPlay,
        target: target,
        effects: effects,
        adapter: adapter,
        autoPlay: autoPlay,
        onComplete: onComplete,
        controller: controller,
      ),
    );
  }
}
