import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });
  testWidgets('SettingsScreen displays form fields and switches', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    expect(find.text('My Settings'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('SAVE SETTINGS'), findsOneWidget);
  });

  testWidgets('Toggling switch and saving settings updates state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    final Finder nameField = find.widgetWithText(TextField, 'Full name');
    final Finder addressField = find.widgetWithText(TextField, 'Home address');
    final Finder emailField = find.widgetWithText(TextField, 'Email');
    final Finder patronNumberField =
        find.widgetWithText(TextField, 'Patron number');

    await tester.enterText(nameField, 'Alex Smith');
    await tester.enterText(addressField, '10 Elm Road, Portsmouth');
    await tester.enterText(emailField, 'alex@example.com');
    await tester.enterText(patronNumberField, '1234');

    final Finder switchFinder = find.byType(Switch);
    await tester.dragUntilVisible(
        switchFinder, find.byType(SettingsScreen), Offset(0, -10));

    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();

    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pump();

    expect(find.text('Settings saved for Alex Smith'), findsOneWidget);

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    expect(await prefs.getString(prefName), 'Alex Smith');
    expect(await prefs.getString(prefAddress), '10 Elm Road, Portsmouth');
    expect(
      await prefs.getString(prefEmail),
      'alex@example.com',
    );
    expect(
      await prefs.getString(prefPatronNumber),
      '1234',
    );
    expect(await prefs.getBool(prefNewsletter), isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

    expect(await prefs.getString(prefName), 'Alex Smith');
    expect(await prefs.getString(prefAddress), '10 Elm Road, Portsmouth');
    expect(
      await prefs.getString(prefEmail),
      'alex@example.com',
    );
    expect(
      await prefs.getString(prefPatronNumber),
      '1234',
    );
    final Switch reopenedSwitch = tester.widget<Switch>(find.byType(Switch));
    expect(reopenedSwitch.value, isTrue);
  });

  testWidgets('SettingsScreen pre-fills saved settings on open', (
    WidgetTester tester,
  ) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefName: 'Abdul Kadir',
      prefAddress: 'Portsmouth Guildhall, PO1 2AJ',
      prefEmail: 'abdul.kadir@portsmouthcc.gov.uk',
      prefPatronNumber: '1234',
      prefNewsletter: true,
    });

    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Abdul Kadir'), findsOneWidget);
    expect(find.text('Portsmouth Guildhall, PO1 2AJ'), findsOneWidget);
    expect(find.text('abdul.kadir@portsmouthcc.gov.uk'), findsOneWidget);
    expect(find.text('1234'), findsOneWidget);
    final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isTrue);
  });
}
