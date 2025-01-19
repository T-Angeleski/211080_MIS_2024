import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab3_211080/models/joke.dart';
import 'package:lab3_211080/providers/jokes_provider.dart';
import 'package:lab3_211080/providers/favorites_manager.dart';

class JokeTypeScreen extends StatelessWidget {
  final String jokeType;

  const JokeTypeScreen({super.key, required this.jokeType});

  @override
  Widget build(BuildContext context) {
    final jokesProvider = Provider.of<JokesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("$jokeType Jokes")),
      body: FutureBuilder<List<Joke>>(
        future: jokesProvider.fetchJokesByType(jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No jokes found"));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];

                return Consumer<FavoritesManager>(
                  builder: (context, favoritesManager, child) {
                    final isFavorite = favoritesManager.isFavorite(joke);

                    return ListTile(
                      title: Text(joke.setup),
                      subtitle: Text(joke.punchline),
                      trailing: IconButton(
                        onPressed: () {
                          favoritesManager.toggleFavorite(joke);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
