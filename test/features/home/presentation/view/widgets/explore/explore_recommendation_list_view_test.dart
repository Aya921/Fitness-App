import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_recommendation_list_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_recommendation_list_view.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_recommendation_list_view_test.mocks.dart';

@GenerateMocks([ExploreCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExploreCubit mockExploreCubit;

  const fakeMuscles = [
    MuscleEntity(image: "test.png", name: "Chest"),
    MuscleEntity(image: "test.png", name: "Back"),
    MuscleEntity(image: "test.png", name: "Arms"),
  ];

  const successState = ExploreState(
    randomMusclesState: StateStatus.success(fakeMuscles),
  );

  const loadingState = ExploreState(
    randomMusclesState: StateStatus.loading(),
  );

  setUp(() {
    mockExploreCubit = MockExploreCubit();
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ExploreCubit>.value(
        value: mockExploreCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: ExploreRecommendationListView()),
        ),
      ),
    );
  }

  testWidgets("verify structure", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(find.text(l10n.recommendationTodyText), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(1));
  });

  testWidgets("loading state: shows 6 skeleton items", (tester) async {
    when(mockExploreCubit.state).thenReturn(loadingState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(loadingState));

    await tester.pumpWidget(prepareWidget());
    await tester.pump();

await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ExploreRecommendationListItem), findsNWidgets(6));
  });

  testWidgets("sucess state: shows correct number of list items", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(ExploreRecommendationListItem), findsNWidgets(3));
    expect(find.text("Chest"), findsOneWidget);
    expect(find.text("Back"), findsOneWidget);
    expect(find.text("Arms"), findsOneWidget);
  });

  testWidgets("ListView scroll direction is horizontal", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final listView = tester.widget<ListView>(find.byType(ListView));
    expect(listView.scrollDirection, Axis.horizontal);
  });

  testWidgets("scroll through items", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final listFinder = find.byType(ListView);
    final scrollableFinder = find.descendant(
      of: listFinder,
      matching: find.byType(Scrollable),
    );

    await tester.scrollUntilVisible(
      find.text("Arms"),
      200,
      scrollable: scrollableFinder,
    );

    expect(find.text("Arms"), findsOneWidget);
  });
}
