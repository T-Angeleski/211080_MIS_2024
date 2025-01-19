import 'package:flutter/material.dart';
import 'package:lab3_211080/screens/random_joke_screen.dart';
import 'favorites_screen.dart';
import 'joke_type_screen.dart';
import 'package:lab3_211080/services/api_services.dart';
import 'package:lab3_211080/widgets/joke_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joke Types"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: JokeService.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No joke types found"));
          } else {
            return ListView(
              children: snapshot.data!.map((type) {
                return JokeCard(
                  title: type,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokeTypeScreen(jokeType: type),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
