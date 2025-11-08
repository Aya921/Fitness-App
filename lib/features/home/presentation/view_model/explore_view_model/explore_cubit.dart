import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/meals_categories_entity/meals_categories_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_random_entity/muscles_random_entity.dart';
import 'package:fitness/features/home/domain/use_case/explore_use_case/explore_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_intents.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class ExploreCubit extends Cubit<ExploreState> {
  final ExploreUseCase _exploreUseCase;
  ExploreCubit(this._exploreUseCase) :super(const ExploreState());

   Future<void> doIntent({required ExploreIntents intent}) async {
    switch (intent) {
      
      case GetHomeData():
       _getHomeData();
       break;
    }
  }

Future<void> _getHomeData() async{

  _getMuscleGroupes();
  _getRandomMuscles();
}
  Future<void> _getRandomMuscles() async{
    emit(state.copyWith(randomMusclesState: const StateStatus.loading()));
    await Future.delayed(const Duration(seconds: 2)); // بس علشان تشوفي الـ skeleton

    final randomMusclesData = await _exploreUseCase.getRandomMuscles();
    switch(randomMusclesData){
      case SuccessResult<List<MusclesRandomEntity>>():
       
        emit(state.copyWith(randomMusclesState: StateStatus.success(randomMusclesData.successResult)));
        break;
      case FailedResult<List<MusclesRandomEntity>>():
    
         emit(state.copyWith(randomMusclesState: StateStatus.failure(
           ResponseException(message: randomMusclesData.errorMessage)
         )));
       break;
    }
  }

   Future<void> _getMuscleGroupes() async{
    emit(state.copyWith(musclesGroupState: const StateStatus.loading()));
    final muscleGroupsData = await _exploreUseCase.getMusclesGroup();
    switch(muscleGroupsData){
      case SuccessResult<List<MusclesGroupEntity>>():
       
        emit(state.copyWith(musclesGroupState: StateStatus.success(muscleGroupsData.successResult)));
        break;
      case FailedResult<List<MusclesGroupEntity>>():
         emit(state.copyWith(musclesGroupState: StateStatus.failure(
           ResponseException(message: muscleGroupsData.errorMessage)
         )));
       break;
    }
  }



}