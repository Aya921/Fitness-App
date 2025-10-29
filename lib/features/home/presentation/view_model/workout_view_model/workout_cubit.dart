import 'package:bloc/bloc.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/workout/difficulty_level_entitiy.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';
import 'package:fitness/features/home/domain/usecase/get_all_exercises_use_case.dart';
import 'package:fitness/features/home/domain/usecase/get_difficulty_levels_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/workout_view_model/workout_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkoutCubit extends Cubit<WorkoutStates> {
  final GetAllExercisesUseCase _allExercisesUseCase;
  final GetDifficultyLevelsUseCase _difficultyLevelsUseCase;

  WorkoutCubit(this._allExercisesUseCase, this._difficultyLevelsUseCase)
      : super(WorkoutStates());

  int currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false;


  Future<void> loadLevels() async {
    emit(state.copyWith(levelsStatus: const StateStatus.loading()));

    final result = await _difficultyLevelsUseCase.call();

    switch (result) {
      case SuccessResult<List<LevelEntity>>():
        emit(state.copyWith(
          levelsStatus: StateStatus.success(result.successResult),
        ));
      case FailedResult<List<LevelEntity>>():
        emit(state.copyWith(
          levelsStatus: StateStatus.failure(
            ResponseException(message: result.errorMessage),
          ),
        ));
    }
  }
  Future<void> loadExercises({bool loadMore = false}) async {
    if (isLoadingMore) return;
    if (loadMore && !hasMore) return;

    isLoadingMore = true;

    if (!loadMore) {
      currentPage = 1;
      emit(state.copyWith(
        exercisesStatus: const StateStatus.loading(),
        allExercises: [],
        filteredExercises: [],
        exercisesCountByLevel: {},
      ));
    }

    final result = await _allExercisesUseCase.call(page: currentPage);

    switch (result) {
      case SuccessResult<List<ExerciseEntity>>():
        final newData = result.successResult;

        final updatedList = loadMore
            ? [...state.allExercises, ...newData]
            : newData;

        hasMore = newData.isNotEmpty;
        currentPage++;
        isLoadingMore = false;


        final Map<String, int> levelCounts = {};
        for (final exercise in updatedList) {
          final level = exercise.difficultyLevel ?? 'Unknown';
          levelCounts[level] = (levelCounts[level] ?? 0) + 1;
        }

        final currentLevel = state.selectedLevel;
        final filtered = currentLevel != null && currentLevel.isNotEmpty
            ? updatedList.where((ex) => ex.difficultyLevel == currentLevel).toList()
            : updatedList;

        emit(state.copyWith(
          allExercises: updatedList,
          filteredExercises: filtered,
          exercisesCountByLevel: levelCounts,
          exercisesStatus: StateStatus.success(filtered),
        ));

      case FailedResult<List<ExerciseEntity>>():
        isLoadingMore = false;
        emit(state.copyWith(
          exercisesStatus: StateStatus.failure(
            ResponseException(message: result.errorMessage),
          ),
        ));
    }
  }

  void filterExercisesByLevel(String level) {
    final filtered = state.allExercises
        .where((ex) => ex.difficultyLevel == level)
        .toList();

    emit(state.copyWith(
      filteredExercises: filtered,
      selectedLevel: level,
    ));
  }
}
