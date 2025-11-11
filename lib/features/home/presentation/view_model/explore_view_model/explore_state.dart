import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/exercise_model/exercise_model.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';

class ExploreState extends Equatable {
  final StateStatus<List<MuscleEntity>> randomMusclesState;
  final StateStatus<List<MusclesGroupEntity>> musclesGroupState;
   final StateStatus<MusclesGroupIdResponseEntity> musclesGroupById;
   final StateStatus<AuthEntity> userData;
   final StateStatus<List<ExerciseEntity>> exersicesState;

  const ExploreState({
    this.randomMusclesState = const StateStatus.initial(),
    this.musclesGroupState = const StateStatus.initial(),
    this.userData = const StateStatus.initial(),
    this.musclesGroupById =const StateStatus.initial(),
    this.exersicesState =const StateStatus.initial()});

  ExploreState copyWith({
    final StateStatus<List<MuscleEntity>>? randomMusclesState,
    final StateStatus<List<MusclesGroupEntity>>? musclesGroupState,
    final  StateStatus<MusclesGroupIdResponseEntity>? musclesGroupById,
    final StateStatus<AuthEntity>? userData,
    final StateStatus<List<ExerciseEntity>>? exersicesState
  }) {
    return ExploreState(
      randomMusclesState: randomMusclesState ?? this.randomMusclesState,
      musclesGroupState: musclesGroupState ?? this.musclesGroupState,
      musclesGroupById:  musclesGroupById ?? this.musclesGroupById,
      userData: userData ?? this.userData,
      exersicesState: exersicesState ?? this.exersicesState
    );
  }

  @override
  List<Object?> get props => [
    randomMusclesState,
    musclesGroupState,
    musclesGroupById,
    userData,
    exersicesState
  ];
}
