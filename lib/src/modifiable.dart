import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'animations/align_animation.dart';
part 'animations/animate.dart';
part 'widgets/action.dart';
part 'widgets/align.dart';
part 'widgets/decoration.dart';
part 'widgets/flex.dart';
part 'widgets/input.dart';
part 'widgets/insets.dart';
part 'widgets/position.dart';
part 'widgets/size.dart';
part 'widgets/theme.dart';
part 'widgets/transformations.dart';

class SimpleModifier extends Modifier<SimpleModifier> {}

/// A tool to create modifications by chaining them.
///
/// ```dart
/// Text('Hello').modifier(modifier.size(100,100));
/// ```
SimpleModifier get modifier => SimpleModifier();

/// The extension for [Widget]
///
///
///
extension ModifiableWidgetExtension on Widget {
  ModifiedChild modify() => ModifiedChild(child: this);

  Widget modifier(Modifier modifications) =>
      Modifiable(modifications: modifications, child: this);

  Widget contextModifier(Modifier Function(BuildContext) func) =>
      Builder(builder: (c) => Modifiable(modifications: func(c), child: this));
}

///
///
///
///
typedef ModifiableWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

///
///
///
///
abstract interface class ModifiableBase {
  Widget build(BuildContext context, Widget child);
}

///
///
///
///
///
abstract class BuildableModifiable extends ModifiableBase {
  BuildableModifiable({required this.builder});

  final ModifiableWidgetBuilder builder;

  @override
  Widget build(BuildContext context, Widget child) => builder(context, child);
}

///
///
///
///
///
///
///
///
class AnimateModifiable extends ModifiableBase {
  AnimateModifiable({
    this.key,
    this.effects,
    this.onInit,
    this.onPlay,
    this.onComplete,
    this.autoPlay = true,
    this.delay,
    this.controller,
    this.adapter,
    this.value,
    this.target,
  });

  final Key? key;
  final List<Effect<dynamic>>? effects;
  final void Function(AnimationController)? onInit;
  final void Function(AnimationController)? onPlay;
  final void Function(AnimationController)? onComplete;
  final bool? autoPlay;
  final Duration? delay;
  final AnimationController? controller;
  final Adapter? adapter;
  final double? value;
  final double? target;

  AnimateModifiable copyWith({
    Key? key,
    Widget child = const SizedBox.shrink(),
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
    return AnimateModifiable(
      adapter: adapter ?? this.adapter,
      autoPlay: autoPlay ?? this.autoPlay,
      controller: controller ?? this.controller,
      delay: delay ?? this.delay,
      effects: effects ?? this.effects,
      key: key ?? this.key,
      onComplete: onComplete ?? this.onComplete,
      onInit: onInit ?? this.onInit,
      onPlay: onPlay ?? this.onPlay,
      target: target ?? this.target,
      value: value ?? this.value,
    );
  }

  @override
  Widget build(BuildContext context, Widget child) {
    return Animate(
      delay: delay,
      key: key,
      onComplete: onComplete,
      onInit: onInit,
      onPlay: onPlay,
      target: target,
      value: value,
      controller: controller,
      autoPlay: autoPlay,
      adapter: adapter,
      effects: effects,
      child: child,
    );
  }
}

///
///
///
///
///
///
///
///
mixin class Modifier<T extends ModifiableBase> implements ModifiableBase {
  Modifier();

  final _modifiables = <ModifiableBase>[];

  T addEffect(Effect effect) {
    final index = _modifiables.lastIndexWhere((e) => e is AnimateModifiable);
    if (index.isNegative || _modifiables.last is! AnimateModifiable) {
      _modifiables.add(AnimateModifiable(effects: [effect]));
      return this as T;
    }

    final animate = _modifiables[index] as AnimateModifiable;

    final effects = [...?animate.effects];
    _modifiables
      ..removeAt(index)
      ..add(animate.copyWith(effects: effects..add(effect)));
    return this as T;
  }

  T addModifiable(ModifiableBase modifiable) {
    _modifiables.add(modifiable);
    return this as T;
  }

  @override
  Widget build(BuildContext context, Widget child) {
    log((_modifiables.toString()));
    if (_modifiables.isEmpty) return child;

    final reversedModifiables = _modifiables.reversed;
    Widget newChild = reversedModifiables.first.build(context, child);

    for (final modifiable in reversedModifiables.skip(1)) {
      newChild = modifiable.build(context, newChild);
    }

    return newChild;
  }
}

///
///
///
///
///
///
///
class ModifiedChild extends StatefulWidget with Modifier<ModifiedChild> {
  ModifiedChild({super.key, required this.child});

  final Widget child;

  @override
  ModifiedChild addModifiable(ModifiableBase modifiable) {
    super.addModifiable(modifiable);
    return this;
  }

  @override
  ModifiedChild addEffect(Effect effect) {
    super.addEffect(effect);
    return this;
  }

  @override
  State<ModifiedChild> createState() => ModifierState();
}

class ModifierState extends State<ModifiedChild> {
  @override
  Widget build(BuildContext context) => widget.build(context, widget.child);

  @override
  String toStringShort() => 'Modifiable${widget.child.toStringShort()}';
}

///
///
///
///
///
///
///
///
class Modifiable extends StatefulWidget {
  ///
  ///
  ///
  const Modifiable({
    super.key,
    required this.child,
    this.modifications,
    this.modificationsBuilder,
  }) : assert(
          modifications == null && modificationsBuilder != null ||
              modifications != null && modificationsBuilder == null,
        );

  ///
  ///
  final Widget child;

  ///
  ///
  final ModifiableBase? modifications;

  ///
  ///
  final Modifier Function(BuildContext context)? modificationsBuilder;

  @override
  State<Modifiable> createState() => _ModifiableState();
}

class _ModifiableState extends State<Modifiable> {
  @override
  Widget build(BuildContext context) {
    if (widget.modificationsBuilder != null) {
      final modifier = widget.modificationsBuilder!.call(context);
      return modifier.build(context, widget.child);
    }
    return widget.modifications!.build(context, widget.child);
  }

  @override
  String toStringShort() {
    return 'Modifiable${widget.child.toStringShort()}';
  }
}
