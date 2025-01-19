import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab3_211080/providers/favorites_manager.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Jokes")),
      body: favoritesManager.favorites.isEmpty
          ? const Center(child: Text("No favorite jokes yet"))
          : ListView.builder(
              itemCount: favoritesManager.favorites.length,
              itemBuilder: (context, index) {
                final joke = favoritesManager.favorites[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    onPressed: () {
                      favoritesManager.toggleFavorite(joke);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}
