import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/select_widget_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testTitle = 'Test Item';

  Widget prepareWidget({
    required String title,
    bool isSelected = false,
    required Function() onTap,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: SelectWidgetItem(
            title: title,
            isSelected: isSelected,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  testWidgets('verify SelectWidgetItem structure', (tester) async {
    await tester.pumpWidget(prepareWidget(
      title: testTitle,
      onTap: () {},
    ));
    await tester.pumpAndSettle();

    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(2));
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(testTitle), findsOneWidget);
  });

  testWidgets('verify indicator Container has circular shape', (tester) async {
    await tester.pumpWidget(prepareWidget(
      title: testTitle,
      onTap: () {},
    ));
    await tester.pumpAndSettle();

    final containers = tester.widgetList<Container>(find.byType(Container));
    final indicatorContainer = containers.last;
    final decoration = indicatorContainer.decoration as BoxDecoration;

    expect(decoration.shape, BoxShape.circle);
  });

  testWidgets('verify CircleAvatar has correct properties', (tester) async {
    await tester.pumpWidget(prepareWidget(
      title: testTitle,
      isSelected: true,
      onTap: () {},
    ));
    await tester.pumpAndSettle();

    final circleAvatar = tester.widget<CircleAvatar>(
      find.byType(CircleAvatar),
    );

    expect(circleAvatar.radius, 8);
    expect(circleAvatar.backgroundColor, AppColors.orange[AppColors.baseColor]);
  });

  testWidgets('verify onTap callback is called when tapped', (tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(prepareWidget(
      title: testTitle,
      onTap: () {
        wasTapped = true;
      },
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    expect(wasTapped, isTrue);
  });

  testWidgets('verify different titles are displayed correctly',
      (tester) async {
    await tester.pumpWidget(prepareWidget(
      title: 'First Title',
      onTap: () {},
    ));
    await tester.pumpAndSettle();

    expect(find.text('First Title'), findsOneWidget);

    await tester.pumpWidget(prepareWidget(
      title: 'Second Title',
      onTap: () {},
    ));
    await tester.pumpAndSettle();

    expect(find.text('Second Title'), findsOneWidget);
    expect(find.text('First Title'), findsNothing);
  });
}