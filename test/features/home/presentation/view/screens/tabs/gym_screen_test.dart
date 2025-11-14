import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/gym_screen.dart';
import 'package:fitness/features/home/presentation/view/widgets/gym/gridview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'gym_screen_test.mocks.dart';

@GenerateMocks([BottomNavigationCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBottomNavigationCubit mockBottomNav;


  final fakeGroups = [
    const MusclesGroupEntity(id: "1", name: "Chest"),
    const MusclesGroupEntity(id: "2", name: "Back"),
  ];


  final fakeMuscles = [
    const MuscleEntity(id: "10", name: "Upper Chest", image: ""),
    const MuscleEntity(id: "11", name: "Lower Chest", image: ""),
  ];


  final successState = BottomNavigationState(
    index: 1,
    muscleGroupsData: fakeGroups,
    selectedGroupId: "1",
    muscleByGroupId: {
      "1": MusclesGroupIdResponseEntity(muscles: fakeMuscles),
      "2": const MusclesGroupIdResponseEntity(muscles: []),
    },
  );


  setUp(() {
    mockBottomNav = MockBottomNavigationCubit();

    provideDummy<BottomNavigationState>(const BottomNavigationState(index: 0));
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<BottomNavigationCubit>.value(
        value: mockBottomNav,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: GymScreen(),
        ),
      ),
    );
  }

  group("GymScreen Tests", () {
    testWidgets("renders correct structure when data is loaded", (tester) async {
      when(mockBottomNav.state).thenReturn(successState);
      when(mockBottomNav.stream).thenAnswer(
        (_) => Stream.value(successState),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(GridviewWidget), findsOneWidget);
      expect(find.text("Workouts"), findsOneWidget);
    });

    testWidgets("displays TabBarWidget with correct titles", (tester) async {
      when(mockBottomNav.state).thenReturn(successState);
      when(mockBottomNav.stream).thenAnswer(
        (_) => Stream.value(successState),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.text("Chest"), findsOneWidget);
      expect(find.text("Back"), findsOneWidget);
    });

    testWidgets("GridviewWidget shows correct number of items", (tester) async {
      when(mockBottomNav.state).thenReturn(successState);
      when(mockBottomNav.stream).thenAnswer(
        (_) => Stream.value(successState),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(GridviewWidget), findsOneWidget);
      expect(find.text("Upper Chest"), findsOneWidget);
      expect(find.text("Lower Chest"), findsOneWidget);
    });
 
  });
  tearDown(getIt.reset);
}
