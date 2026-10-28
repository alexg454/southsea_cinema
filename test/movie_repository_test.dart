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

    test('getSandwichById returns matching sandwich when id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('spider-man_itsv');

      expect(movie, isNotNull);
      expect(movie?.name, 'Spider-Man: Into the Spider Verse');
      expect(movie?.ageRating, 'PG');
      expect(movie?.price, 5.99);
    });

    test('getSandwichById returns null when id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });
  });
}
