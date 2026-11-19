import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  setUp(() {
    BasketRepository.instance.clear();
    rootBundle.clear();
  });

  group('SouthseaCinemaApp widget tests', () {
    testWidgets('display home page with title and movie cards',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: HomeView()),
      ));
      await tester.pumpAndSettle();

      expect(find.text(appTitle), findsOneWidget);
    });
  });

  group('SouthseaCinemaApp smoke tests', () {
    testWidgets('displays HomeView as home', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text(appTitle), findsOneWidget);
    });

    testWidgets('displays movie cards correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.text('Spider-Man: Into the Spider Verse'), findsOneWidget);
      expect(find.text('£5.99'), findsNWidgets(2));
      expect(find.text('BOOK TICKETS'), findsNWidgets(2));
      expect(find.text('BOOK NOW'), findsNWidgets(2));
    });

    testWidgets(
        'tapping BOOK NOW navigates to MovieListing with selected movie and tickets are added to basket',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: HomeView()),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Spider-Man: Into the Spider Verse'), findsOneWidget);
      expect(find.byType(DropdownMenu<int>), findsOneWidget);
      expect(find.textContaining('£5.99'), findsOneWidget);

      await tester.dragUntilVisible(
          find.text('Add to Order'), find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      expect(find.text('Add to Order'), findsOneWidget);
      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(find.text('Added 1 ticket to basket!'), findsOneWidget);
    });

    testWidgets('DropdownMenu selection works to change number of tickets',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: HomeView()),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Spider-Man: Into the Spider Verse'), findsOneWidget);

      await tester.dragUntilVisible(find.byType(DropdownMenu<int>),
          find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pump();

      await tester.dragUntilVisible(
          find.text('3').last, find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3').last);
      await tester.pump();

      await tester.dragUntilVisible(
          find.text('Add to Order'), find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(find.text('Added 3 tickets to basket!'), findsOneWidget);
    });

    testWidgets('Test navigating to one movie, then back to another',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: HomeView()),
      ));
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Spider-Man: Into the Spider Verse'), findsOneWidget);

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(find.text('BOOK NOW').last,
          find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      await tester.tap(find.text('BOOK NOW').last);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Tenet'), findsOneWidget);
    });

    testWidgets('Test adding tickets from two movies, removing some and checking out', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Spider-Man: Into the Spider Verse'), findsOneWidget);

      await tester.dragUntilVisible(find.text('Add to Order'),
          find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add to Order'));
      await tester.pumpAndSettle();
      expect(find.text('Added 1 ticket to basket!'), findsOneWidget);

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(find.text('BOOK NOW').last,
          find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      await tester.tap(find.text('BOOK NOW').last);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Tenet'), findsOneWidget);

      await tester.dragUntilVisible(find.text('Add to Order'),
          find.byType(MovieListing), Offset(0, -100));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add to Order'));
      await tester.pumpAndSettle();
      expect(find.text('Added 1 ticket to basket!'), findsOneWidget);

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('My Basket'));
      await tester.pumpAndSettle();

      expect(find.text('1 x Spider-Man: Into the Spider Verse'), findsOneWidget);
      expect(find.text('1 x Tenet'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pump();

      expect(find.text('1 x Spider-Man: Into the Spider Verse'), findsOneWidget);
      expect(find.text('1 x Tenet'), findsNothing);

      await tester.tap(find.text('CHECKOUT'));
      await tester.pump();
    });
  });
}
