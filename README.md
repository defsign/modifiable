# Less boilerplate when creating widgets, adding animations and applying themes.


```dart
// With modifiable
Text('Hello world.').modified()
    ..square(200) 
    ..decorationImage('https://source.unsplash.com/random')
    ..paddingX(10)
    ..alignCenter();
```

```dart
// Without modifiable
Container(
    width: 200,
    height: 200,
    padding: EdgeInsets.symmetric(horizontal: 10)
    decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
            image: NetworkImage('https://source.unsplash.com/random'),
        )
    ),
    alignment: Alignment.center,
    child: Txet('Hello world.'),
);
```