import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    test('getMovies returns two movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains valid movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie spiderman = movies[0];
      expect(spiderman.id, 'spider-man_itsv');
      expect(spiderman.name, 'Spider-Man: Into the Spider Verse');
      expect(spiderman.ageRating, 'PG');
      expect(spiderman.price, 5.99);
      expect(spiderman.imagePath, isNotNull);

      final Movie tenet = movies[1];
      expect(tenet.id, 'tenet');
      expect(tenet.name, 'Tenet');
      expect(tenet.ageRating, '15');
      expect(tenet.price, 5.99);
      expect(tenet.imagePath, isNotNull);
    });

    test('getMovieById returns matching sandwich when id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('spider-man_itsv');

      expect(movie, isNotNull);
      expect(movie?.name, 'Spider-Man: Into the Spider Verse');
      expect(movie?.ageRating, 'PG');
      expect(movie?.price, 5.99);
    });

    test('getMovieById returns null when id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });

    test('getMoviesByPrice returns matching movie(s) when price exists', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie>? movies = repository.getMoviesByPrice(5.99);

      expect(movies, isNotNull);
      expect(movies?[0].id, 'spider-man_itsv');
      expect(movies?[1].id, 'tenet');
    });

    test('getMoviesByPrice returns null when price does not exist', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie>? movies = repository.getMoviesByPrice(5.99);

      expect(movies, isNotNull);
      expect(movies?[0].id, 'spider-man_itsv');
      expect(movies?[1].id, 'tenet');
    });

    test('getMoviesByAgeRating returns matching movie(s) when age rating exists', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie>? movies = repository.getMoviesByAgeRating('15');

      expect(movies, isNotNull);
      expect(movies?[0].id, 'tenet');
    });

    test('getMoviesByAgeRating returns null when age rating does not exist', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie>? movies = repository.getMoviesByAgeRating('non-existent');

      expect(movies, isNull);
    });
  });
}
