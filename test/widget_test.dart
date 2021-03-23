import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:iop_wallet/src/pages/home/home.dart';

void main() {
  testWidgets('Home Page has a title, buttons and icons',
      (WidgetTester tester) async {
    await tester.pumpWidget(HomePage());

    final addCredentialFinder =
        find.widgetWithText(ElevatedButton, 'Add Credential');
    expect(addCredentialFinder, findsOneWidget);

    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(
        find.byIcon(
          Icons.wallet_membership,
        ),
        findsOneWidget);

    expect(find.text('IOP Wallet'), findsOneWidget);
  }, skip: true);

  testWidgets('Click on Add Credential to new page',
      (WidgetTester tester) async {
    await tester.pumpWidget(HomePage());

    await tester.tap(find.byType(IconButton).first);
    print(find.byType(IconButton).first);
    await tester.pumpAndSettle();
    // Create Finders
    final buttonFinder = find.text('Settings');

    expect(buttonFinder, findsOneWidget);
  }, skip: true);
}
