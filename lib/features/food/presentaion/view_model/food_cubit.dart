import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/food/domain/entities/meals_categories.dart';
import 'package:fitness/features/food/domain/use_case/get_meals_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/features/food/presentaion/view_model/food_states.dart';
import 'package:injectable/injectable.dart';

import 'food_intent.dart';
@injectable
class FoodCubit extends Cubit<FoodStates>{
  FoodCubit(this._getMealsCategoriesUseCase):super(const FoodStates());
  final GetMealsCategoriesUseCase _getMealsCategoriesUseCase;
  Future<void> doIntent({required FoodIntent intent})async {
    switch(intent){

      case FoodInitializationIntent():

         _getMealsCategories();
    }
  }
  Future<void> _getMealsCategories()async{
    final result=await _getMealsCategoriesUseCase.call();
    emit(
        state.copyWith(
          mealsCategories: const StateStatus.loading(),
        )
    );
    switch(result){

      case SuccessResult<List<MealCategoryEntity>>():
      emit(
        state.copyWith(
          mealsCategories: StateStatus.success(result.successResult),
        )
      );
      break;
      case FailedResult<List<MealCategoryEntity>>():
        emit(
            state.copyWith(
              mealsCategories: StateStatus.failure(
                  ResponseException(message: result.errorMessage)),
            )
        );
        break;
    }
  }
}