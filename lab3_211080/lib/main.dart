import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab3_211080/firebase_options.dart';
import 'package:lab3_211080/screens/main_screen.dart';
import 'package:lab3_211080/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:lab3_211080/providers/jokes_provider.dart';
import 'package:lab3_211080/providers/favorites_manager.dart';
import 'package:timezone/data/latest_all.dart' as tz;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();

  final notificationService = NotificationService();
  await notificationService.initialize();

  // Schedule the daily notification at 10:00 AM
  await notificationService.scheduleDailyNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JokesProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}
