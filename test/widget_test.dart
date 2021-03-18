
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:iop_wallet/src/pages/home.dart';

void main() {
  testWidgets('Home Page has a title, buttons and icons',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HomePage());

    final addCredentialFinder =
        find.widgetWithText(ElevatedButton, 'Add Credential');
    expect(addCredentialFinder, findsOneWidget);

    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(
        find.byIcon(
          Icons.wallet_membership,
        ),
        findsOneWidget);

    expect(find.text('IOP Wallet'), findsOneWidget);
  });

  testWidgets('Click on Add Credential to new page',
      (WidgetTester tester) async {
    await tester.pumpWidget(HomePage());

    await tester.tap(find.byType(IconButton).first);
    print(find.byType(IconButton).first);
    await tester.pumpAndSettle();
    // Create Finders
    final buttonFinder = find.text('Settings');

    expect(buttonFinder, findsOneWidget);
  });
}
