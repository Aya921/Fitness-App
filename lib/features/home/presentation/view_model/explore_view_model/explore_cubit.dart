import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/use_case/get_logged_user_use_case.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_intents.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/explore_use_case/explore_use_case.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  final ExploreUseCase _exploreUseCase;
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  ExploreCubit(this._exploreUseCase, this._getLoggedUserUseCase)
    : super(const ExploreState());
  final Map<String, MusclesGroupIdResponseEntity> cachedMuscleGroups = {};
  bool _isPrefetching = false;
  Future<void> doIntent({required ExploreIntents intent}) async {
    switch (intent) {
      case GetHomeData():
        _getHomeData();
        break;
      case GetMusclesGroupByIdIntent():
        _getMusclesGroupById(intent.id);
        break;
    }
  }

  Future<void> _getHomeData() async {
    _getLoggedUsetData();
    _getMuscleGroupes();
    _getRandomMuscles();
  }

  Future<void> _getRandomMuscles() async {
    emit(state.copyWith(randomMusclesState: const StateStatus.loading()));
    final randomMusclesData = await _exploreUseCase.getRandomMuscles();
    switch (randomMusclesData) {
      case SuccessResult<List<MuscleEntity>>():
        emit(
          state.copyWith(
            randomMusclesState: StateStatus.success(
              randomMusclesData.successResult,
            ),
          ),
        );
        break;
      case FailedResult<List<MuscleEntity>>():
        emit(
          state.copyWith(
            randomMusclesState: StateStatus.failure(
              ResponseException(message: randomMusclesData.errorMessage),
            ),
          ),
        );
        break;
    }
  }

  Future<void> _getMuscleGroupes() async {
    emit(state.copyWith(musclesGroupState: const StateStatus.loading()));

    final muscleGroupsData = await _exploreUseCase.getMusclesGroup();

    switch (muscleGroupsData) {
      case SuccessResult<List<MusclesGroupEntity>>():
        final groups = muscleGroupsData.successResult;
        emit(state.copyWith(musclesGroupState: StateStatus.success(groups)));

        if (groups.isNotEmpty) {
          await _getMusclesGroupById(groups.first.id);
        }

        _prefetchAllGroups(groups);
        break;

      case FailedResult<List<MusclesGroupEntity>>():
        emit(
          state.copyWith(
            musclesGroupState: StateStatus.failure(
              ResponseException(message: muscleGroupsData.errorMessage),
            ),
          ),
        );
        break;
    }
  }


  Future<void> _prefetchAllGroups(List<MusclesGroupEntity> groups) async {
    if (_isPrefetching) return;
    _isPrefetching = true;

    for (final group in groups) {
      final id = group.id;
      if (id == null) continue;

      if (cachedMuscleGroups.containsKey(id)) continue;

      final result = await _exploreUseCase.getAllMusclesGroupById(id);
      if (result is SuccessResult<MusclesGroupIdResponseEntity>) {
        cachedMuscleGroups[id] = result.successResult;
      }
    }

    _isPrefetching = false;
  }

  Future<void> _getMusclesGroupById(String? id) async {
    if (id == null) return;
    if (cachedMuscleGroups.containsKey(id)) {
      emit(
        state.copyWith(
          musclesGroupById: StateStatus.success(cachedMuscleGroups[id]!),
        ),
      );
      return;
    }
    emit(state.copyWith(musclesGroupById: const StateStatus.loading()));
    final musclesGroupById = await _exploreUseCase.getAllMusclesGroupById(id);

    switch (musclesGroupById) {
      case SuccessResult<MusclesGroupIdResponseEntity>():
        cachedMuscleGroups[id] = musclesGroupById.successResult;
        emit(
          state.copyWith(
            musclesGroupById: StateStatus.success(
              musclesGroupById.successResult,
            ),
          ),
        );
        // print(
        //   "Loaded group: ${musclesGroupById.successResult.muscles?.length}",
        // );
        break;
      case FailedResult<MusclesGroupIdResponseEntity>():
        emit(
          state.copyWith(
            musclesGroupById: StateStatus.failure(
              ResponseException(message: musclesGroupById.errorMessage),
            ),
          ),
        );
        break;
    }
  }

  Future<void> _getLoggedUsetData() async {
    emit(state.copyWith(userData: const StateStatus.loading()));
    final response = await _getLoggedUserUseCase.call();
    switch (response) {
      case SuccessResult<AuthEntity>():
        emit(
          state.copyWith(userData: StateStatus.success(response.successResult)),
        );
        break;
      case FailedResult<AuthEntity>():
        emit(
          state.copyWith(
            userData: StateStatus.failure(
              ResponseException(message: response.errorMessage),
            ),
          ),
        );
        break;
    }
  }
}
