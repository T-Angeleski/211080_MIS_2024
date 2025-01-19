import 'package:flutter/foundation.dart';
import 'package:lab3_211080/models/joke.dart';
import 'package:lab3_211080/services/api_services.dart';

class JokesProvider with ChangeNotifier {
  final Map<String, List<Joke>> _jokesByType = {};

  List<Joke> getJokesByType(String type) {
    return _jokesByType[type] ?? [];
  }

  Future<List<Joke>> fetchJokesByType(String type) async {
    if (_jokesByType.containsKey(type)) {
      return _jokesByType[type]!;
    }

    try {
      final jokes = await JokeService.fetchJokesByType(type);
      _jokesByType[type] = jokes;
      notifyListeners();
      return jokes;
    } catch (e) {
      throw Exception("Failed to fetch jokes for type $type");
    }
  }
}
