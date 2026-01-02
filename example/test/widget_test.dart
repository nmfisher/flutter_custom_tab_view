import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:custom_tab_view_example/main.dart';

void main() {
  testWidgets('Example app loads with all examples', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExampleApp());

    // Verify that the app title is present
    expect(find.text('Custom Tab View - Styling Examples'), findsOneWidget);

    // Verify that example tabs exist (checking for unique parts of each)
    expect(find.text('Dark Theme'), findsWidgets);
    expect(find.text('Light Theme'), findsWidgets);
    expect(find.text('Blue Theme'), findsWidgets);
    expect(find.text('Custom Colors'), findsWidgets);
    expect(find.text('Custom Mix Style'), findsWidgets);
  });

  testWidgets('WindowsStyleTabView displays tabs', (WidgetTester tester) async {
    // Test the DarkThemeExample widget directly
    await tester.pumpWidget(
      const MaterialApp(
        home: DarkThemeExample(),
      ),
    );

    // Verify that tabs are displayed
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Verify icons are present
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('Light theme example works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LightThemeExample(),
      ),
    );

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
  });

  testWidgets('Blue theme example works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BlueThemeExample(),
      ),
    );

    expect(find.text('Inbox'), findsOneWidget);
    expect(find.text('Sent'), findsOneWidget);
    expect(find.text('Drafts'), findsOneWidget);
    expect(find.text('Archive'), findsOneWidget);
  });
}
