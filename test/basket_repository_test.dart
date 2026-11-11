import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

const Movie movie1 = Movie(
  id: 'spider-man_itsv',
  name: 'Spider-Man: Into the Spider Verse',
  ageRating: 'PG',
  description: 'test description',
  price: 5.99,
  imagePath: 'assets/images/spider-man_itsv.jpg',
);

const Movie movie2 = Movie(
  id: 'tenet',
  name: 'Tenet',
  ageRating: '15',
  description:'test description',
  price: 5.99,
  imagePath: 'assets/images/tenet.jpg',
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketRepository tests', () {
    test('starts empty with zero totals', () {
      final BasketRepository basket = BasketRepository.instance;
      expect(basket.getItems().length, 0);
      expect(basket.getTotalItems(), 0);
      expect(basket.totalItemCount, 0);
      expect(basket.getSubtotal(), 0.0);
    });

    test('adds items and calculates subtotal correctly', () {
      final BasketRepository basket = BasketRepository.instance;
      const BasketItem item1 = BasketItem(
        movie: movie1, 
        quantity: 3
      );
      const BasketItem item2 = BasketItem(
        movie: movie2, 
        quantity: 1
      );

      basket.addItem(item1);
      basket.addItem(item2);

      expect(basket.getItems().length, 2);
      expect(basket.getTotalItems(), 4);
      expect(basket.totalItemCount, 4);
      expect(basket.getSubtotal(), 23.96);
    });

    test('removes items correctly', () {
      final BasketRepository basket = BasketRepository.instance;
      const BasketItem item1 = BasketItem(
        movie: movie1, 
        quantity: 3
      );

      basket.addItem(item1);
      expect(basket.getItems().length, 1);

      basket.removeItem(0);
      expect(basket.getItems().length, 0);
      expect(basket.getSubtotal(), 0.0);
    });

    test('clears items correctly', () {
      final BasketRepository basket = BasketRepository.instance;
      const BasketItem item1 = BasketItem(
        movie: movie1, 
        quantity: 3
      );

      basket.addItem(item1);
      basket.addItem(item1);
      basket.addItem(item1);

      basket.clear();

      expect(basket.getItems().length, 0);
      expect(basket.getTotalItems(), 0);
      expect(basket.totalItemCount, 0);
      expect(basket.getSubtotal(), 0.0);
    });
  });
}