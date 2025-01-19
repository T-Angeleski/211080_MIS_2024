import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const JokeCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: onTap,
      ),
    );
  }
}
