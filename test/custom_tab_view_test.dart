import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:custom_tab_view/custom_tab_view.dart';

void main() {
  testWidgets('WindowsStyleTabView renders tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WindowsStyleTabView(
            tabs: [
              WindowsStyleTab(
                title: 'Tab 1',
                icon: Icons.home,
                content: const Text('Content 1'),
              ),
              WindowsStyleTab(
                title: 'Tab 2',
                icon: Icons.settings,
                content: const Text('Content 2'),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Tab 1'), findsOneWidget);
    expect(find.text('Tab 2'), findsOneWidget);
    expect(find.text('Content 1'), findsOneWidget);
  });

  testWidgets('WindowsStyleTabView switches tabs on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WindowsStyleTabView(
            tabs: [
              WindowsStyleTab(
                title: 'Tab 1',
                icon: Icons.home,
                content: const Text('Content 1'),
              ),
              WindowsStyleTab(
                title: 'Tab 2',
                icon: Icons.settings,
                content: const Text('Content 2'),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Content 1'), findsOneWidget);
    expect(find.text('Content 2'), findsNothing);

    await tester.tap(find.text('Tab 2'));
    await tester.pump();

    expect(find.text('Content 2'), findsOneWidget);
  });
}
