import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('Creates a Movie model instance with given parameters - whole price',
        () {
      const movie = Movie(
          id: 'spiderman_itsv',
          name: 'Spider-man: Into the Spider Verse',
          ageRating: 'PG',
          description: 'Test description',
          price: 5,
          imagePath: 'Test image path');

      expect(movie.id, 'spiderman_itsv');
      expect(movie.name, 'Spider-man: Into the Spider Verse');
      expect(movie.ageRating, 'PG');
      expect(movie.description, 'Test description');
      expect(movie.price, 5);
      expect(movie.formattedPrice, '£5.00');
      expect(movie.imagePath, 'Test image path');
    });

    test(
        'Creates a Movie model instance with given parameters - price with pence',
        () {
      const movie = Movie(
          id: 'spiderman_itsv',
          name: 'Spider-man: Into the Spider Verse',
          ageRating: 'PG',
          description: 'Test description',
          price: 5.75,
          imagePath: 'Test image path');

      expect(movie.id, 'spiderman_itsv');
      expect(movie.name, 'Spider-man: Into the Spider Verse');
      expect(movie.ageRating, 'PG');
      expect(movie.description, 'Test description');
      expect(movie.price, 5.75);
      expect(movie.formattedPrice, '£5.75');
      expect(movie.imagePath, 'Test image path');
    });

    test('JSON conversion preserves every movie field', () {
      final Map<String, dynamic> data = <String, dynamic>{
        'id': 'spider-man_itsv',
        'name': 'Spider-Man: Into the Spider Verse',
        'ageRating': 'PG',
        'description': 'test description',
        'price': 2.50,
        'imagePath': 'assets/images/spider-man_itsv.jpg'
      };

      final Movie movie = Movie.fromJson(data);
      expect(movie.id, 'spider-man_itsv');
      expect(movie.name, 'Spider-Man: Into the Spider Verse');
      expect(movie.ageRating, 'PG');
      expect(movie.description, 'test description');
      expect(movie.price, 2.50);
      expect(movie.imagePath, 'assets/images/spider-man_itsv.jpg');
      expect(movie.toJson(), data);
    });

    test('fromJson accepts a whole-number price', () {
      final Map<String, dynamic> data = <String, dynamic>{
        'id': 'test',
        'name': 'Test',
        'description': 'Test description',
        'ageRating': 'Age rating',
        'price': 5,
        'imagePath': 'Test image path',
      };

      final Movie movie = Movie.fromJson(data);
      expect(movie.price, 5.0);
      expect(movie.price, isA<double>());
    });
  });
}
