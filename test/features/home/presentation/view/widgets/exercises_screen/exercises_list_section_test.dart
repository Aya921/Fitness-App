import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/exercises_list_section.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'exercises_list_section_test.mocks.dart';

@GenerateMocks([ExercisesCubit])
void main() {
  late MockExercisesCubit mockCubit;

  setUp(() {
    mockCubit = MockExercisesCubit();

    when(mockCubit.stream).thenAnswer((_) => const Stream<ExercisesStates>.empty());
    when(mockCubit.state).thenReturn(const ExercisesStates());
  });

  Widget prepareWidget(ExercisesStates state) {
    when(mockCubit.state).thenReturn(state);

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
          child: Scaffold(
            body: ExercisesListSection(
              scrollController: ScrollController(),
              primeMoverMuscleImage: 'https://fakeimg.pl/100x100',
            ),
          ),
        ),
      ),
    );
  }

  group('ExercisesListSection Widget Tests', () {
    testWidgets('renders loading state', (tester) async {
      const state = ExercisesStates(
        exercisesByLevelAndMuscleStatus: StateStatus.loading(),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget(state));
        expect(find.byKey(const Key(WidgetKey.exercisesListLoadingKey)), findsOneWidget);
      });
    });

    testWidgets('renders failure state', (tester) async {
      const state = ExercisesStates(
        exercisesByLevelAndMuscleStatus:
        StateStatus.failure(ResponseException(message: 'Error loading')),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget(state));
        expect(find.byKey(const Key(WidgetKey.exercisesListErrorKey)), findsOneWidget);
      });
    });

    testWidgets('renders empty state when no exercises', (tester) async {
      const state = ExercisesStates(
        exercisesByLevelAndMuscleStatus: StateStatus.success([]),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget(state));
        expect(find.byKey(const Key(WidgetKey.exercisesListEmptyKey)), findsOneWidget);
      });
    });

    testWidgets('renders exercises list when data is available', (tester) async {
      final exercises = [
        const ExerciseEntity(name: 'Push Ups'),
        const ExerciseEntity(name: 'Squats'),
      ];

      final state = ExercisesStates(
        exercisesByLevelAndMuscleStatus: StateStatus.success(exercises),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget(state));

        expect(find.byKey(const Key(WidgetKey.exercisesListViewKey)), findsOneWidget);
        expect(find.text('Push Ups'), findsOneWidget);
        expect(find.text('Squats'), findsOneWidget);
      });
    });
  });
}
