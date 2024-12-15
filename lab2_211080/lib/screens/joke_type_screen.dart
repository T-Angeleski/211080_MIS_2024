import 'package:flutter/material.dart';
import 'package:lab2_211080/models/joke.dart';
import 'package:lab2_211080/services/api_services.dart';

class JokeTypeScreen extends StatelessWidget {
  final String jokeType;

  const JokeTypeScreen({super.key, required this.jokeType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$jokeType Jokes")),
      body: FutureBuilder<List<Joke>>(
        future: JokeService.fetchJokesByType(jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No jokes found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final joke = snapshot.data![index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                );
              },
            );
          }
        },
      ),
    );
  }
}
