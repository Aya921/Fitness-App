import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_intents.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';

void main() {
  late BottomNavigationCubit bottomNavigationCubit;

  setUp(() {
    bottomNavigationCubit = BottomNavigationCubit();
  });

  tearDown(() {
    bottomNavigationCubit.close();
  });

  const initialState = BottomNavigationState(index: 0);

  group('BottomNavigationCubit initialization', () {
    test('initial state should have index = 0 and no data', () {
      expect(bottomNavigationCubit.state, equals(initialState));
      expect(bottomNavigationCubit.state.index, equals(0));
      expect(bottomNavigationCubit.state.muscleGroupsData, isNull);
      expect(bottomNavigationCubit.state.muscleByGroupId, isNull);
    });
  });

  group('GoToTabIntent', () {
    blocTest<BottomNavigationCubit, BottomNavigationState>(
      'emits state with updated index when GoToTabIntent is called',
      build: () => bottomNavigationCubit,
      act: (cubit) => cubit.doIntent( GoToTab(index: 2)),
      expect: () => [
        isA<BottomNavigationState>().having(
          (state) => state.index,
          'index',
          equals(2),
        ),
      ],
    );
  });

  group('GoToTabWithDataIntent', () {
    // final musclesGroupList = [
    //   const MusclesGroupEntity(id: "1", name: "Chest"),
    //   const MusclesGroupEntity(id: "2", name: "Back"),
    // ];

    // final musclesGroupByIdMap = {
    //   "1": const MusclesGroupIdResponseEntity(
    //     message: "Success",
    //     musclesGroup: MusclesGroupEntity(id: "1", name: "Chest"),
    //     muscles: [],
    //   ),
    // };

   

 
  });

  group('SelectGroupIntent', () {
    blocTest<BottomNavigationCubit, BottomNavigationState>(
      'emits state with selectedGroupId when SelectGroupIntent is called',
      build: () => bottomNavigationCubit,
      act: (cubit) => cubit.doIntent( SelectGroupIntent("abc123")),
      expect: () => [
        isA<BottomNavigationState>().having(
          (state) => state.selectedGroupId,
          'selectedGroupId',
          equals("abc123"),
        ),
      ],
    );
  });

  group('SyncDataIntent', () {
    final updatedMusclesGroupList = [
      const MusclesGroupEntity(id: "10", name: "Legs"),
    ];

    final updatedMuscleByGroupId = {
      "10": const MusclesGroupIdResponseEntity(
        message: "ok",
        musclesGroup: MusclesGroupEntity(id: "10", name: "Legs"),
        muscles: [],
      ),
    };

    blocTest<BottomNavigationCubit, BottomNavigationState>(
      'emits state with updated muscleGroupsData and muscleByGroupId when SyncDataIntent is called',
      build: () => bottomNavigationCubit,
      act: (cubit) => cubit.doIntent(
        SyncDataIntent(
          muscleGroupsData: updatedMusclesGroupList,
          muscleByGroupId: updatedMuscleByGroupId,
        ),
      ),
      expect: () => [
        isA<BottomNavigationState>()
            .having((state) => state.muscleGroupsData, 'muscleGroupsData', updatedMusclesGroupList)
            .having((state) => state.muscleByGroupId, 'muscleByGroupId', updatedMuscleByGroupId),
      ],
    );

    
  });

  group('Multiple sequential intents', () {
    final groups = [
      const MusclesGroupEntity(id: "1", name: "Arms"),
    ];
    final groupById = {
      "1": const MusclesGroupIdResponseEntity(
        message: "ok",
        musclesGroup: MusclesGroupEntity(id: "1", name: "Arms"),
        muscles: [],
      ),
    };

    blocTest<BottomNavigationCubit, BottomNavigationState>(
      'emits correct states when multiple intents are triggered in sequence',
      build: () => bottomNavigationCubit,
      act: (cubit) => [
        cubit.doIntent( GoToTab(index: 1)),
        cubit.doIntent( SelectGroupIntent("group1")),
        cubit.doIntent(SyncDataIntent(
          muscleGroupsData: groups,
          muscleByGroupId: groupById,
        )),
      ],
      expect: () => [
        isA<BottomNavigationState>().having((state) => state.index, 'index', equals(1)),
        isA<BottomNavigationState>().having((state) => state.selectedGroupId, 'selectedGroupId', equals("group1")),
        isA<BottomNavigationState>()
            .having((state) => state.muscleGroupsData, 'muscleGroupsData', groups)
            .having((state) => state.muscleByGroupId, 'muscleByGroupId', groupById),
      ],
    );
  });
}