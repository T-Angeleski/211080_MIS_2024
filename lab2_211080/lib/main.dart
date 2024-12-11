import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/random_joke_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => const MainScreen(),
        '/random-joke': (context) => const RandomJokeScreen(),
      },
    );
  }
}
