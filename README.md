# Modifiable

Modifiable is a versatile Flutter package designed to streamline the creation, styling, and animation of basic widgets, significantly reducing boilerplate code.

## Overview

Creating and styling widgets in Flutter often involves writing verbose code, which can be time-consuming, difficult to edit and sometimes hard to read. Modifiable simplifies this process by offering a concise syntax that empowers developers to customize widgets effortlessly.

### Without Modifiable

```dart
Container(
    width: 200,
    height: 200,
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
            image: NetworkImage('https://source.unsplash.com/random'),
        ),
    ),
    alignment: Alignment.center,
    child: Text('Hello world.'),
);
```

### With Modifiable

```dart
Text('Hello world.')
    .modified()
    ..square(200) 
    ..decorationImage('https://source.unsplash.com/random')
    ..paddingX(10)
    ..alignCenter();
```

## Syntax

Modifiable offers a flexible syntax, enabling developers to choose the style that best suits their preferences and project requirements.

### Chained Modifier

```dart
Text('Hello world.')
    .modified()
    ..size(200, 150)
    ..backgroundColor(Colors.red)
    ..alignCenter();
```

### Modifier Variable

```dart
final modifications = modifier
    ..size(200, 150)
    ..backgroundColor(Colors.red)
    ..alignCenter();

const Text('Hello world').modifier(modifications);
```

### Modifier Builder

```dart
Modifier modBuilder(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return modifier
        ..size(200, 150)
        ..backgroundColor(primary)
        ..alignCenter();
} 

const Text('Hello world').contextModifier(modBuilder);
```

### Modifiable Widget

```dart
Modifiable(
    modifications: modifier
        ..size(200, 150)
        ..backgroundColor(Colors.red)
        ..alignCenter(),
    child: const Text('Hello world'),
);
```

## Installation

To use Modifiable in your Flutter project, add it to your `pubspec.yaml`:

```yaml
dependencies:
  modifiable: ^0.0.3
```

Then, import it in your Dart code:

```dart
import 'package:modifiable/modifiable.dart';
```

## Getting Started

1. **Create a Widget:** Start by creating a widget you want to modify.

2. **Apply Modifications:** Use Modifiable's intuitive syntax to apply the desired modifications to your widget.

3. **Enjoy Concise Code:** Enjoy cleaner and more readable code without sacrificing customization options.

## Features

- **Simplified Syntax:** Reduce boilerplate code and enhance readability with Modifiable's concise syntax.
- **Versatile Customization:** Modify various widget properties such as size, color, alignment, and more.
- **Flexible Usage:** Choose from different syntax styles or create custom modifier functions to suit your preferences.

## Examples

Explore the examples directory for more usage examples and demonstrations of Modifiable's capabilities.


## Support

For any questions, issues, or feature requests, please [open an issue](https://github.com/defsign/modifiable/issues) or [contact us](mailto:1def.signal@gmail.com).
