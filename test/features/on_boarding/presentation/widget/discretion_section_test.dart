import 'package:fitness/features/on_boarding/presentation/widget/discretion_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/responsive/size_provider.dart';

void main() {
  testWidgets('DiscretionSection renders correctly and verifies content', (WidgetTester tester) async {
    await tester.pumpWidget(
      const SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: MaterialApp(
          home: Scaffold(
            body: DiscretionSection(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(Constants.descriptionOnBoarding), findsOneWidget);
    expect(find.byType(Padding), findsOneWidget);
  });
}
