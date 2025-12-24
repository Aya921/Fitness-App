import 'dart:ui';

import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/container_detials_complete_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: ContainerDetialsCompleteRegister(child: child),
        ),
      ),
    );
  }

  testWidgets('verify ContainerDetialsCompleteRegister structure',
      (tester) async {
    const testChild = Text('Test Child');

    await tester.pumpWidget(prepareWidget(child: testChild));
    await tester.pumpAndSettle();

    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.text('Test Child'), findsOneWidget);
  });

  testWidgets('verify Container has correct padding', (tester) async {
    const testChild = Text('Test Child');

    await tester.pumpWidget(prepareWidget(child: testChild));
    await tester.pumpAndSettle();

    final context =
        tester.element(find.byType(ContainerDetialsCompleteRegister));
    final container = tester.widget<Container>(find.byType(Container));

    expect(
      container.padding,
      EdgeInsets.symmetric(vertical: context.setWidth(24)),
    );
  });


  testWidgets('verify BackdropFilter is applied', (tester) async {
    const testChild = Text('Test Child');

    await tester.pumpWidget(prepareWidget(child: testChild));
    await tester.pumpAndSettle();
    final backdropFilter =
        tester.widget<BackdropFilter>(find.byType(BackdropFilter));
    expect(backdropFilter, isNotNull);
    expect(backdropFilter.filter, isA<ImageFilter>());
  });
  
}