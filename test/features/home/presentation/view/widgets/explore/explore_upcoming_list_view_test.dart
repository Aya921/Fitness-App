import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_upcoming_list_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_upcoming_list_view.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'explore_upcoming_list_view_test.mocks.dart';

@GenerateMocks([ExploreCubit, BottomNavigationCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExploreCubit mockExploreCubit;
  late MockBottomNavigationCubit mockBottomNavCubit;

  final fakeGroupItems = [
    const MusclesGroupEntity(id: "1", name: "Chest"),
  ];

  final fakeMuscles = [
    const MuscleEntity(id: "10", name: "Upper Chest", image: ""),
    const MuscleEntity(id: "11", name: "Lower Chest", image: ""),
  ];

 
  final successState = ExploreState(
    musclesGroupState: StateStatus.success(fakeGroupItems),
    musclesGroupById:
        StateStatus.success(MusclesGroupIdResponseEntity(muscles: fakeMuscles)),
        
  );

  
  final loadingState = ExploreState(
    musclesGroupState: StateStatus.success(fakeGroupItems),
    musclesGroupById: const StateStatus.loading(),
   
  );

  setUp(() {
    mockExploreCubit = MockExploreCubit();
    mockBottomNavCubit = MockBottomNavigationCubit();

    provideDummy<ExploreState>(const ExploreState());
    provideDummy<BottomNavigationState>(const BottomNavigationState(index: 0));
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ExploreCubit>.value(value: mockExploreCubit),
          BlocProvider<BottomNavigationCubit>.value(value: mockBottomNavCubit),
        ],
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: ExploreUpcomingListView()),
        ),
      ),
    );
  }

  group("ExploreUpcomingListView Tests", () {
    testWidgets("verify structure", (tester) async {
      when(mockExploreCubit.state).thenReturn(successState);
     when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));
    when(mockExploreCubit.cachedMuscleGroups).thenReturn({
  "1": MusclesGroupIdResponseEntity(muscles: fakeMuscles),
});
when(mockBottomNavCubit.state)
    .thenReturn(const BottomNavigationState(index: 0));

when(mockBottomNavCubit.stream).thenAnswer(
  (_) => Stream<BottomNavigationState>
          .value(const BottomNavigationState(index: 0))
      .asBroadcastStream(),
);

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(FittedBox), findsWidgets);
      expect(find.byType(ListView), findsNWidgets(2));
      expect(find.byType(ExploreUpcomingListItem), findsNWidgets(2));
    });

    testWidgets("renders section title and See All", (tester) async {
         when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));
    when(mockExploreCubit.cachedMuscleGroups).thenReturn({
  "1": MusclesGroupIdResponseEntity(muscles: fakeMuscles),
});
when(mockBottomNavCubit.state)
    .thenReturn(const BottomNavigationState(index: 0));

when(mockBottomNavCubit.stream).thenAnswer(
  (_) => Stream<BottomNavigationState>
          .value(const BottomNavigationState(index: 0))
      .asBroadcastStream(),
);
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.text(l10n.upcomingWorkOutsText), findsOneWidget);
      expect(find.text(l10n.seeAllHomeText), findsOneWidget);
    });

    testWidgets("displays TabBarWidget titles correctly", (tester) async {
      when(mockExploreCubit.state).thenReturn(successState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));
  when(mockExploreCubit.cachedMuscleGroups).thenReturn({
  "1": MusclesGroupIdResponseEntity(muscles: fakeMuscles),
});
when(mockBottomNavCubit.state)
    .thenReturn(const BottomNavigationState(index: 0));

when(mockBottomNavCubit.stream).thenAnswer(
  (_) => Stream<BottomNavigationState>
          .value(const BottomNavigationState(index: 0))
      .asBroadcastStream(),
);
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.text("Chest"), findsOneWidget);
    });

    testWidgets("loading state shows skeleton + 6 placeholder items",
        (tester) async {
      when(mockExploreCubit.state).thenReturn(loadingState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(loadingState));
       when(mockExploreCubit.cachedMuscleGroups).thenReturn({
  "1": MusclesGroupIdResponseEntity(muscles: fakeMuscles),
});
when(mockBottomNavCubit.state)
    .thenReturn(const BottomNavigationState(index: 0));

when(mockBottomNavCubit.stream).thenAnswer(
  (_) => Stream<BottomNavigationState>
          .value(const BottomNavigationState(index: 0))
      .asBroadcastStream(),
);
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(ExploreUpcomingListItem), findsNWidgets(6));
    });

    testWidgets("success state loads correct number of items",
        (tester) async {
      when(mockExploreCubit.state).thenReturn(successState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));
  when(mockExploreCubit.cachedMuscleGroups).thenReturn({
  "1": MusclesGroupIdResponseEntity(muscles: fakeMuscles),
});
when(mockBottomNavCubit.state)
    .thenReturn(const BottomNavigationState(index: 0));

when(mockBottomNavCubit.stream).thenAnswer(
  (_) => Stream<BottomNavigationState>
          .value(const BottomNavigationState(index: 0))
      .asBroadcastStream(),
);
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(ExploreUpcomingListItem), findsNWidgets(2));
      expect(find.text("Upper Chest"), findsOneWidget);
      expect(find.text("Lower Chest"), findsOneWidget);
    });

    testWidgets("layout alignment checks", (tester) async {
      when(mockExploreCubit.state).thenReturn(successState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));
  when(mockExploreCubit.cachedMuscleGroups).thenReturn({
  "1": MusclesGroupIdResponseEntity(muscles: fakeMuscles),
});
when(mockBottomNavCubit.state)
    .thenReturn(const BottomNavigationState(index: 0));

when(mockBottomNavCubit.stream).thenAnswer(
  (_) => Stream<BottomNavigationState>
          .value(const BottomNavigationState(index: 0))
      .asBroadcastStream(),
);
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);

      final column = tester.widget<Column>(
        find.byWidgetPredicate(
          (w) => w is Column && w.crossAxisAlignment == CrossAxisAlignment.start,
        ),
      );
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });
  });
}
