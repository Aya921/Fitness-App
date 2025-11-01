import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/exercise_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  const fakeImage = 'https://fakeimg.pl/100x100';
  const fakeName = 'Push Ups';
  const fakeVideoLink = 'https://example.com/video';

  Widget prepareWidget(Widget child) {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        routes: {
          AppRoutes.exeVideoScreen: (context) =>
              const Scaffold(body: Center(child: Text('Video Screen'))),
        },
        home: Scaffold(body: child),
      ),
    );
  }

  group('ExerciseListItem Widget Tests', () {
    testWidgets('renders all elements correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          prepareWidget(
            const ExerciseListItem(
              primeMoverMuscleImage: fakeImage,
              exerciseName: fakeName,
              videoLink: fakeVideoLink,
            ),
          ),
        );
        expect(
          find.byKey(const Key(WidgetKey.exerciseImageKey)),
          findsOneWidget,
        );

        expect(
          find.byKey(const Key(WidgetKey.exerciseNameKey)),
          findsOneWidget,
        );

        expect(
          find.byKey(const Key(WidgetKey.exerciseGroupLabelKey)),
          findsOneWidget,
        );

        expect(
          find.byKey(const Key(WidgetKey.playIconContainerKey)),
          findsOneWidget,
        );
        expect(find.byKey(const Key(WidgetKey.playIconKey)), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      });
    });

    testWidgets('navigates to video screen when tapped', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          prepareWidget(
            const ExerciseListItem(
              primeMoverMuscleImage: fakeImage,
              exerciseName: fakeName,
              videoLink: fakeVideoLink,
            ),
          ),
        );

        await tester.tap(find.byType(ExerciseListItem));
        await tester.pumpAndSettle();

        expect(find.text('Video Screen'), findsOneWidget);
      });
    });
  });
}
