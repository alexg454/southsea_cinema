import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:flutter/services.dart';

void main() {
  setUp(() {
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
  });
}
