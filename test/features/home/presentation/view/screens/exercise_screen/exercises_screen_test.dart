import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/exercise_screen/exercises_screen.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/exercises_list_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/header_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/level_tabs_section.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'exercises_screen_test.mocks.dart';

@GenerateMocks([ExercisesCubit])
void main() {
  late MockExercisesCubit mockCubit;

  const MuscleEntity fakeMuscle = MuscleEntity(
    id: "1",
    name: "Chest",
    image: "https://fakeimg.pl/100x100",
  );

  setUp(() {
    mockCubit = MockExercisesCubit();

    when(mockCubit.stream)
        .thenAnswer((_) => const Stream<ExercisesStates>.empty());
    when(mockCubit.state).thenReturn(const ExercisesStates());

    when(mockCubit.doIntent(intent: anyNamed('intent')))
        .thenAnswer((_) async {});
  });

  Widget prepareWidget({ MuscleEntity? muscle}) {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<ExercisesCubit>.value(
          value: mockCubit,
          child: ExercisesScreen(primMoverMuscle: muscle),
        ),
      ),
    );
  }

  group('ExercisesScreen Widget Test', () {
    testWidgets('renders main sections correctly', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget(muscle: fakeMuscle));
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(HeaderSection), findsOneWidget);
        expect(find.byType(LevelTabsSection), findsOneWidget);
        expect(find.byType(ExercisesListSection), findsOneWidget);
      });
    });
  });
  testWidgets('calls LoadLevelsByMuscleIntent on initState', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(prepareWidget(muscle: fakeMuscle));
      await tester.pump();

      verify(mockCubit.doIntent(
        intent: anyNamed('intent'),
      )).called(1);
    });
  });
  testWidgets('renders empty SizedBox when primMoverMuscle is null', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        prepareWidget(muscle: const MuscleEntity(id: '', name: '', image: '')),
      );
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });
  });
  testWidgets('renders background image correctly', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(prepareWidget(muscle: fakeMuscle));
      await tester.pump();

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.image, isNotNull);
      expect(decoration.image!.fit, BoxFit.cover);
    });
  });


}
