import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('Creates a Movie model instance with given parameters - whole price', () {
      const movie = Movie(
        id: 'spiderman_itsv',
        name: 'Spider-man: Into the Spider Verse',
        ageRating: 'PG',
        description: 'Test description',
        price: 5,
        imagePath: 'Test image path'
      );

      expect(movie.id, 'spiderman_itsv');
      expect(movie.name, 'Spider-man: Into the Spider Verse');
      expect(movie.ageRating, 'PG');
      expect(movie.description, 'Test description');
      expect(movie.price, 5);
      expect(movie.formattedPrice, '£5.00');
      expect(movie.imagePath, 'Test image path');
    });

    test('Creates a Movie model instance with given parameters - price with pence', () {
      const movie = Movie(
        id: 'spiderman_itsv',
        name: 'Spider-man: Into the Spider Verse',
        ageRating: 'PG',
        description: 'Test description',
        price: 5.75,
        imagePath: 'Test image path'
      );

      expect(movie.id, 'spiderman_itsv');
      expect(movie.name, 'Spider-man: Into the Spider Verse');
      expect(movie.ageRating, 'PG');
      expect(movie.description, 'Test description');
      expect(movie.price, 5.75);
      expect(movie.formattedPrice, '£5.75');
      expect(movie.imagePath, 'Test image path');
    });
  });
}