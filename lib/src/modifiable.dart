import 'package:flutter/gestures.dart';
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

/// A simple modifier for creating modifications by chaining them.
///
/// The `SimpleModifier` class extends the `Modifier` mixin, allowing for the dynamic
/// composition of modifications by chaining them together. It provides a convenient
/// way to apply modifications to widgets using chaining syntax.
class SimpleModifier extends Modifier<SimpleModifier> {}

/// A tool for creating modifications and applying them to widgets using chaining syntax.
///
/// The `modifier` global variable provides a convenient way to create modifications
/// and apply them to widgets using chaining syntax. It returns a `SimpleModifier`
/// instance, which can then be used to chain modification methods and apply them to widgets.
///
/// Example usage:
/// ```dart
/// Text('Hello').modify(modifier.alignCenter());
/// ```
SimpleModifier get modifier => SimpleModifier();

/// An extension on the Widget class to simplify the creation and modification of widgets with modifiable behavior.
///
/// This extension provides three methods for creating and modifying widgets:
/// - `modify()`: Creates a `ModifiedChild` widget with the current widget as its child, enabling the application of modifiables using chaining syntax.
/// - `modifier()`: Creates a `Modifiable` widget with the specified `Modifier` object applied to the current widget, allowing for the application of pre-defined modifications.
/// - `contextModifier()`: Creates a `Modifiable` widget with modifications defined by the provided function, which takes a [BuildContext] as input and returns a `Modifier` object, enabling context-sensitive modifications.
extension ModifiableWidgetExtension on Widget {
  /// Creates a `ModifiedChild` widget with the current widget as its child.
  ///
  /// Returns a `ModifiedChild` widget with the current widget as its child,
  /// enabling the application of modifiables using chaining syntax.
  ModifiedChild modify() => ModifiedChild(child: this);

  /// Creates a `Modifiable` widget with the specified `Modifier` object applied to the current widget.
  ///
  /// The [modifications] parameter specifies the modifications to be applied to the current widget.
  ///
  /// Returns a `Modifiable` widget with the specified modifications applied to the current widget.
  Widget modifier(Modifier modifications) =>
      Modifiable(modifications: modifications, child: this);

  /// Creates a `Modifiable` widget with modifications defined by the provided function.
  ///
  /// The [builder] parameter is a function that takes a [BuildContext] as input and returns a `Modifier` object.
  /// This enables context-sensitive modifications to the current widget.
  ///
  /// Returns a `Modifiable` widget with modifications defined by the provided function applied to the current widget.
  Widget contextModifier(Modifier Function(BuildContext) builder) => Builder(
      builder: (c) => Modifiable(modifications: builder(c), child: this));
}

/// A function signature for building modifiable widgets.
///
/// This typedef defines a function signature used for building modifiable widgets.
/// It takes a [BuildContext] and a [Widget] child as parameters,
/// and returns a modified widget incorporating the specified modifications.
///
/// Example usage:
/// ```dart
/// Widget alignmentBuilder(BuildContext context, Widget child) {
///   // Logic to modify the child widget
///   return Align(
///     alignment: Alignment.center,
///     child: child,
///   );
/// }
///
/// typedef AlignmentModifiableBuilder = Widget Function(BuildContext context, Widget child);
/// ```
typedef ModifiableWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

/// A base interface for creating modifiable widgets.
///
/// This interface defines a `build` method, which is responsible for creating and modifying widgets.
/// Implementations of this interface typically wrap the `child` widget with additional logic or widgets
/// and return the modified widget from the `build` method.
abstract interface class ModifiableBase {
  /// Builds and returns a modified widget.
  ///
  /// The [context] parameter provides the build context for the widget.
  /// The [child] parameter is the widget that the modifiable may wrap or modify.
  ///
  /// Returns a widget modified according to the logic implemented by the modifiable.
  Widget build(BuildContext context, Widget child);
}

/// A modifiable with a `builder` parameter.
///
/// This modifiable simplifies the creation of other modifiables by providing a builder function.
/// The builder function takes a [BuildContext] and a [Widget] child as parameters,
/// and returns a widget that incorporates the modifications specified by the modifiable.
///
/// Example usage:
///
/// ```dart
/// class AlignmentModifiable extends BuildableModifiable {
///   AlignmentModifiable({required AlignmentGeometry alignment})
///       : super(builder: (context, child) {
///           return Align(alignment: alignment, child: child);
///         });
/// }
/// ```
abstract class BuildableModifiable extends ModifiableBase {
  /// Constructs a [BuildableModifiable] with the specified [builder] function.
  ///
  /// The [builder] function takes a [BuildContext] and a [Widget] child as parameters,
  /// and returns a widget that incorporates the modifications specified by the modifiable.
  BuildableModifiable({required this.builder});

  /// The builder function used to create the modified widget.
  final ModifiableWidgetBuilder builder;

  @override
  Widget build(BuildContext context, Widget child) => builder(context, child);
}

/// A modifiable widget that wraps its child with animation effects using [Animate].
///
/// This modifiable simplifies the addition of animations to widgets by providing
/// a convenient way to configure and apply animation effects.
class AnimateModifiable extends ModifiableBase {
  /// Constructs an [AnimateModifiable] with optional parameters for configuring animation effects.
  ///
  /// [key] - An optional key to identify the widget.
  /// [effects] - A list of animation effects to apply.
  /// [onInit] - A callback function invoked when the animation controller is initialized.
  /// [onPlay] - A callback function invoked when the animation starts playing.
  /// [onComplete] - A callback function invoked when the animation completes.
  /// [autoPlay] - Whether the animation should start automatically.
  /// [delay] - An optional delay before the animation starts.
  /// [controller] - An optional animation controller to control the animation.
  /// [adapter] - An optional adapter for customizing animation behavior.
  /// [value] - An optional initial value for the animation.
  /// [target] - An optional target value for the animation.
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

  /// A copy constructor that creates a new [AnimateModifiable] with the provided parameters,
  /// replacing any existing parameters with the new ones.
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

/// A mixin class for dynamically composing modifiable widgets.
///
/// The `Modifier` mixin extends the functionality of modifiable widgets by allowing
/// for the dynamic addition of effects and other modifiables during the build process.
/// It implements the `ModifiableBase` interface, providing a `build` method to apply
/// modifications to a child widget.
mixin class Modifier<T extends ModifiableBase> implements ModifiableBase {
  final _modifiables = <ModifiableBase>[];

  /// Adds an effect to the list of modifiables.
  ///
  /// If there are no modifiables or the last modifiable is not an `AnimateModifiable`,
  /// it creates a new `AnimateModifiable` with the provided effect and adds it to the list.
  /// Otherwise, it appends the effect to the effects list of the last `AnimateModifiable` in the list.
  ///
  /// Returns the current instance of the modifiable widget.
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

  /// Adds a modifiable object to the list of modifiables.
  ///
  /// Returns the current instance of the modifiable widget.
  T addModifiable(ModifiableBase modifiable) {
    _modifiables.add(modifiable);
    return this as T;
  }

  @override
  Widget build(BuildContext context, Widget child) {
    if (_modifiables.isEmpty) return child;

    final reversedModifiables = _modifiables.reversed;
    Widget newChild = reversedModifiables.first.build(context, child);

    for (final modifiable in reversedModifiables.skip(1)) {
      newChild = modifiable.build(context, newChild);
    }

    return newChild;
  }
}

/// A StatefulWidget that incorporates modifiable behavior using the `Modifier` mixin.
///
/// The `ModifiedChild` widget extends `StatefulWidget` and includes the `Modifier` mixin
/// to enable dynamic composition of modifiable widgets. It allows for the addition of
/// effects and other modifiables during the build process.
class ModifiedChild extends StatefulWidget with Modifier<ModifiedChild> {
  /// Constructs a `ModifiedChild` widget with the specified [child].
  ///
  /// The [child] parameter is the widget to be modified.
  ModifiedChild({super.key, required this.child});

  /// The widget to be modified by the modifiables.
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

/// The state for the `ModifiedChild` widget.
///
/// This state class is responsible for building the modified child widget
/// using the modifiables added to the widget.
class ModifierState extends State<ModifiedChild> {
  @override
  Widget build(BuildContext context) => widget.build(context, widget.child);

  @override
  String toStringShort() => 'Modifiable${widget.child.toStringShort()}';
}

/// A StatefulWidget for applying modifications to a child widget.
///
/// The `Modifiable` widget is used to apply modifications to its child widget,
/// either directly using a `ModifiableBase` object or via a builder function that
/// returns a `Modifier` object based on the build context.
class Modifiable extends StatefulWidget {
  /// Constructs a `Modifiable` widget with the specified parameters.
  ///
  /// The [child] parameter is the widget to which modifications will be applied.
  /// The [modifications] parameter represents the modifications to apply directly.
  /// The [modificationsBuilder] parameter is a builder function that returns a `Modifier`
  /// object based on the build context, allowing for context-sensitive modifications.
  ///
  /// Either [modifications] or [modificationsBuilder] must be provided, but not both.
  const Modifiable({
    super.key,
    required this.child,
    this.modifications,
    this.modificationsBuilder,
  }) : assert(
          modifications == null && modificationsBuilder != null ||
              modifications != null && modificationsBuilder == null,
        );

  /// The widget to which modifications will be applied.
  final Widget child;

  /// The modifications to apply directly to the child widget.
  final ModifiableBase? modifications;

  /// A builder function that returns a `Modifier` object based on the build context,
  /// allowing for context-sensitive modifications.
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
