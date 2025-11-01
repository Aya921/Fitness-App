import 'package:bloc/bloc.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:fitness/features/home/domain/usecase/get_difficulty_levels_by_muscle_use_case.dart';
import 'package:fitness/features/home/domain/usecase/get_exercises_by_difficulty_and_muscle_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_intent.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@injectable
class ExercisesCubit extends Cubit<ExercisesStates> {
  final GetDifficultyLevelsByMuscleUseCase _difficultyLevelsByMuscleUseCase;
  final GetExercisesByDifficultyAndMuscleUseCase
  _exercisesByDifficultyAndMuscleUseCase;

  ExercisesCubit(
    this._difficultyLevelsByMuscleUseCase,
    this._exercisesByDifficultyAndMuscleUseCase,
  ) : super(const ExercisesStates());

  Future<void> doIntent({required ExercisesIntent intent}) async {
    switch (intent) {
      case LoadLevelsByMuscleIntent():
        await _loadLevelsByMuscle(intent.muscleId);
        break;

      case LoadExercisesByMuscleAndLevelIntent():
        await _loadExercisesByMuscleAndLevel(intent.muscleId, intent.levelId);
        break;

      case ChangeSelectedLevelIntent():
        await _changeSelectedLevel(intent.muscleId, intent.levelId);
        break;

      case LoadMoreExercisesByMuscleAndLevelIntent():
        await _loadExercisesByMuscleAndLevel(
          intent.muscleId,
          intent.levelId,
          loadMore: true,
        );
        break;

      case GetYoutubeIdIntent():
        await _getYoutubeId(intent.videoUrl);
        break;
    }
  }

  int muscleLevelPage = 1;
  bool muscleLevelHasMore = true;
  bool muscleLevelIsLoading = false;

  Future<void> _loadLevelsByMuscle(String primeMoverMuscleId) async {
    emit(state.copyWith(levelsByMuscleStatus: const StateStatus.loading()));

    final result = await _difficultyLevelsByMuscleUseCase.call(
      primeMoverMuscleId,
    );

    switch (result) {
      case SuccessResult<List<LevelEntity>>():
        final levels = result.successResult;

        // load first level
        if (levels.isNotEmpty) {
          final firstLevel = levels.first;
          if (firstLevel.id != null) {
            emit(
              state.copyWith(
                selectedLevelId: firstLevel.id,
                levelsByMuscleStatus: StateStatus.success(levels),
              ),
            );
            await _loadExercisesByMuscleAndLevel(
              primeMoverMuscleId,
              firstLevel.id!,
            );
          }
        } else {
          emit(
            state.copyWith(levelsByMuscleStatus: StateStatus.success(levels)),
          );
        }
      case FailedResult<List<LevelEntity>>():
        emit(
          state.copyWith(
            levelsByMuscleStatus: StateStatus.failure(
              ResponseException(message: result.errorMessage),
            ),
          ),
        );
    }
  }

  Future<void> _loadExercisesByMuscleAndLevel(
    String muscleId,
    String levelId, {
    bool loadMore = false,
  }) async {
    if (muscleLevelIsLoading) return;
    if (loadMore && (!muscleLevelHasMore || muscleLevelPage > 3)) {
      muscleLevelHasMore = false;
      return;
    }
    muscleLevelIsLoading = true;

    if (!loadMore) {
      emit(
        state.copyWith(
          exercisesByLevelAndMuscleStatus: const StateStatus.loading(),
        ),
      );
    }

    final result = await _exercisesByDifficultyAndMuscleUseCase.call(
      muscleId,
      levelId,
      page: muscleLevelPage,
    );

    switch (result) {
      case SuccessResult<List<ExerciseEntity>>():
        final newData = result.successResult;
        final currentData = loadMore
            ? (state.exercisesByLevelAndMuscleStatus.data ?? [])
            : [];

        final List<ExerciseEntity> updated = [...currentData, ...newData];

        muscleLevelHasMore = newData.isNotEmpty;
        if (muscleLevelHasMore) muscleLevelPage++;

        muscleLevelIsLoading = false;

        emit(
          state.copyWith(
            selectedLevelId: levelId,
            exercisesByLevelAndMuscleStatus: StateStatus.success(updated),
          ),
        );
        break;

      case FailedResult<List<ExerciseEntity>>():
        muscleLevelIsLoading = false;
        emit(
          state.copyWith(
            exercisesByLevelAndMuscleStatus: StateStatus.failure(
              ResponseException(message: result.errorMessage),
            ),
          ),
        );
        break;
    }
  }

  Future<void> _changeSelectedLevel(String muscleId, String levelId) async {
    muscleLevelPage = 1;
    if (state.selectedLevelId == levelId) return;
    await _loadExercisesByMuscleAndLevel(muscleId, levelId);
  }

  Future<void> _getYoutubeId(String url) async {
    emit(state.copyWith(youtubeIdStatus: const StateStatus.loading()));

    final String cleanedUrl = url.trim();
    final String? videoId = YoutubePlayer.convertUrlToId(cleanedUrl);
    if (videoId != null && videoId.isNotEmpty) {
      emit(state.copyWith(youtubeIdStatus: StateStatus.success(videoId)));
    } else {
      emit(
        state.copyWith(
          youtubeIdStatus: const StateStatus.failure(
            ResponseException(message: "error fetching video id , this video is not available."),
          ),
        ),
      );
    }
  }
}
