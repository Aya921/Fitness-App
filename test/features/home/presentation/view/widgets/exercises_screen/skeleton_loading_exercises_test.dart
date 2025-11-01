import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/skeleton_loading_exercises.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget prepareWidget(Widget child) {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(body: child),
      ),
    );
  }

  group('SkeletonLoadingExercises Widget Tests', () {
    testWidgets('renders a ListView with 6 skeleton rows', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareWidget(const SkeletonLoadingExercises()));

      expect(find.byType(ListView), findsOneWidget);
      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.semanticChildCount, 6);
    });

    testWidgets('renders blurred skeleton containers', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareWidget(const SkeletonLoadingExercises()));

      final blurFinder = find.byWidgetPredicate(
        (widget) => widget is BackdropFilter,
      );
      expect(blurFinder, findsOneWidget);

      final containerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color != null,
      );
      expect(containerFinder, findsWidgets);
    });

    testWidgets('renders shimmer placeholders (colored containers)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareWidget(const SkeletonLoadingExercises()));

      final shimmerPlaceholders = find.byWidgetPredicate((widget) {
        if (widget is! Container) return false;
        final color = widget.color;
        if (color == null) return false;

        // RGB
        final isWhiteLike =
            color.red > 240 && color.green > 240 && color.blue > 240;

        final isTransparent = color.alpha < 255;
        return isWhiteLike && isTransparent;
      });

      expect(shimmerPlaceholders, findsWidgets);
    });
  });
}
