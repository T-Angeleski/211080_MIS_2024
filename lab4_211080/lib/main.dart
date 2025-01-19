import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/calendar_screen.dart';
import 'screens/event_map_screen.dart';
import 'screens/route_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Schedule App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const CalendarScreen(events: []),
        '/event-map': (context) => const EventMapScreen(events: []),
        '/route': (context) => const RouteScreen(
              startLatitude: 42.0,
              startLongitude: 21.0,
              destinationLatitude: 42.5,
              destinationLongitude: 21.5,
            ),
      },
    );
  }
}
