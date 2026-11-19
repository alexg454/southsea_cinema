import 'dart:convert';
import 'package:southsea_cinema/models/movie.dart';
import 'package:flutter/services.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }

    return const [
      Movie(
        id: 'spider-man_itsv',
        name: 'Spider-Man: Into the Spider Verse',
        ageRating: 'PG',
        description:
            'After gaining superpowers from a spider bite, Miles Morales protects the city as Spider-Man. Soon, he meets alternate versions of himself and gets embroiled in an epic battle to save the multiverse.',
        price: 5.99,
        imagePath: 'assets/images/spider-man_itsv.jpg',
      ),
      Movie(
        id: 'tenet',
        name: 'Tenet',
        ageRating: '15',
        description:
            'When a few objects that can be manipulated and used as weapons in the future fall into the wrong hands, a CIA operative, known as the Protagonist, must save the world.',
        price: 5.99,
        imagePath: 'assets/images/tenet.jpg',
      )
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  List<Movie>? getMoviesByPrice(double price) {
    List<Movie> movies = [];
    for (final movie in getMovies()) {
      if (movie.price == price) {
        movies.add(movie);
      }
    }

    if (movies.isEmpty) return null;
    return movies;
  }

  List<Movie>? getMoviesByAgeRating(String ageRating) {
    List<Movie> movies = [];
    for (final movie in getMovies()) {
      if (movie.ageRating == ageRating) {
        movies.add(movie);
      }
    }

    if (movies.isEmpty) return null;
    return movies;
  }

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      final Movie movie = Movie.fromJson(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }
}
