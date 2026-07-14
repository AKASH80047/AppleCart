import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:basic_tempelate_ui_design/main.dart';
import 'package:basic_tempelate_ui_design/pages/home_page.dart';
import 'package:basic_tempelate_ui_design/pages/product_details_page.dart';

void main() {
  testWidgets('E-Commerce app template smoke test', (WidgetTester tester) async {
    // Set a larger physical screen size to make sure widgets are layout out nicely
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(const AppleMart());
    await tester.pump();

    // Verify that the Home Page renders correctly.
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Flash Deals for You'), findsOneWidget);
    expect(find.text('Iphone 16 Pro Max'), findsOneWidget);
    expect(find.text('Smartwatch Ultra'), findsOneWidget);

    // Verify search hint text
    expect(find.text('Search'), findsOneWidget);

    // Scroll down to make sure the product card is fully visible and clickable
    final productFinder = find.text('Iphone 16 Pro Max');
    await tester.scrollUntilVisible(
      productFinder,
      100.0,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    // Tap on the iPhone 16 Pro Max product card to navigate to Details.
    await tester.tap(productFinder);
    await tester.pumpAndSettle(); // Wait for navigation animation

    // Verify we are on the Product Details page.
    expect(find.byType(ProductDetailsPage), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
    expect(find.text('Buy Now'), findsOneWidget);
    expect(find.text('A Snapshot View'), findsOneWidget);

    // Verify details of the iPhone 16 Pro Max are shown.
    expect(find.text('Desert Titanium'), findsOneWidget);
    expect(find.text('Natural Titanium'), findsOneWidget);
    expect(find.text('512 GB'), findsOneWidget);

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle(); // Wait for navigation transition back

    // Verify we are back on the Home page.
    expect(find.byType(HomePage), findsOneWidget);
  });
}
