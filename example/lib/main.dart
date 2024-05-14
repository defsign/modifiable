import 'package:flutter/material.dart';
import 'package:modifiable/modifiable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizedBox;
    return const MaterialApp(
      title: 'Modifiable Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Modifiable(
              modifications: modifier
                ..square(200)
                ..circularBorderRadius(17)
                ..backgroundColor(Colors.red)
                ..paddingAll(10)
                ..clipCircularRRect(10)
                ..alignCenter(),
              child: Image.network(
                'https://source.unsplash.com/random/5',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Hello').modify()
              ..size(200, 100)
              ..alignCenter()
          ],
        ),
      ),
    );
  }
}
