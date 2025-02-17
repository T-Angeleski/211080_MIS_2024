import 'package:flutter/material.dart';
import 'package:lab3_211080/services/notification_service.dart';
import 'package:lab3_211080/models/joke.dart';
import 'package:lab3_211080/services/api_services.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({super.key});

  void _showJokeNotification(Joke joke) {
    NotificationService().showNotification(
      id: joke.hashCode,
      title: 'New Joke!',
      body: '${joke.setup}\n${joke.punchline}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Random Joke")),
      body: FutureBuilder<Joke>(
        future: JokeService.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No joke found"));
          } else {
            final joke = snapshot.data!;
            _showJokeNotification(joke);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(joke.setup, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  Text(joke.punchline,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
