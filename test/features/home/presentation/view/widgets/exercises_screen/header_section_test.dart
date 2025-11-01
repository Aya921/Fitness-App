import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/header_section.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  Widget prepareWidget({required String name, required String image}) {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: HeaderSection(
            primeMoverMuscleName: name,
            primeMoverMuscleImage: image,
          ),
        ),
      ),
    );
  }

  group('HeaderSection Widget Test', () {
    testWidgets('renders correctly with name and image', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          prepareWidget(name: 'Chest', image: 'https://fakeimg.pl/200x200'),
        );

        await tester.pumpAndSettle();

        expect(find.text('Chest'), findsOneWidget);

        expect(find.byType(Image), findsOneWidget);

        expect(find.byType(CustomPopIcon), findsOneWidget);
        expect(find.byType(Row), findsWidgets);
        expect(find.byType(Column), findsWidgets);
      });
    });

    testWidgets('renders gradient overlay correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          prepareWidget(name: 'Chest', image: 'https://fakeimg.pl/200x200'),
        );

        await tester.pumpAndSettle();

        final container = tester.widget<Container>(
          find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration as BoxDecoration).gradient != null,
          ),
        );

        final BoxDecoration decoration = container.decoration as BoxDecoration;
        expect(decoration.gradient, isA<LinearGradient>());
        expect(
          (decoration.gradient as LinearGradient).colors.first,
          AppColors.gray[90],
        );
      });
    });

    testWidgets('renders fallback safely with empty image and name', (
      tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget(name: '', image: ''));

        await tester.pumpAndSettle();

        expect(find.byType(HeaderSection), findsOneWidget);
      });
    });

    testWidgets('uses correct layout structure', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          prepareWidget(name: 'Shoulder', image: 'https://fakeimg.pl/200x200'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(Stack), findsWidgets);
        expect(find.byType(Column), findsWidgets);
        expect(find.byType(Row), findsWidgets);
        expect(find.byType(SizedBox), findsWidgets);
      });
    });
    testWidgets('renders even with empty name and image', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget(name: '', image: ''));
        await tester.pumpAndSettle();

        expect(find.byType(HeaderSection), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets('contains two bordered containers for min and cal labels', (
      tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          prepareWidget(name: 'Abs', image: 'https://fakeimg.pl/200x200'),
        );
        await tester.pumpAndSettle();

        final containers = tester.widgetList<Container>(
          find.byWidgetPredicate(
            (w) =>
                w is Container &&
                w.decoration is BoxDecoration &&
                (w.decoration as BoxDecoration).border != null,
          ),
        );

        expect(containers.length, greaterThanOrEqualTo(2));
      });
    });
  });
}
