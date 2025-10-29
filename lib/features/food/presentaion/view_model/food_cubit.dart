import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/food/domain/entities/meals_by_category.dart';
import 'package:fitness/features/food/domain/entities/meals_categories.dart';
import 'package:fitness/features/food/domain/use_case/get_meals_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/features/food/presentaion/view_model/food_states.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/get_meals_by_category.dart';
import 'food_intent.dart';
@injectable
class FoodCubit extends Cubit<FoodStates>{
  FoodCubit(this._getMealsCategoriesUseCase,this._getMealsByCategoriesUseCase):super(const FoodStates());
  final GetMealsCategoriesUseCase _getMealsCategoriesUseCase;
  final GetMealsByCategoriesUseCase _getMealsByCategoriesUseCase;
  Future<void> doIntent({required FoodIntent intent})async {
    switch(intent){

      case FoodInitializationIntent():

         _getMealsCategories();
      case MealsByCategoriesIntent():
        _getMealsByCategory(intent.category);
    }
  }
  void _getMealsByCategory(String category)async{
    emit(
        state.copyWith(
          mealsByCategorieStatus: const StateStatus.loading(),
        )
    );
    final result=await _getMealsByCategoriesUseCase.call(category);

    switch(result){

      case SuccessResult<List<MealsByCategory>>():
        emit(
            state.copyWith(
              mealsByCategorieStatus: StateStatus.success(result.successResult),
            )
        );
      case FailedResult<List<MealsByCategory>>():
       emit(state.copyWith(
         errorMealsByCategories: result.errorMessage,
         mealsByCategorieStatus: StateStatus.failure(
           ResponseException(message: result.errorMessage)
         )
       ));

    }
  }
  Future<void> _getMealsCategories()async{
    emit(
        state.copyWith(
          mealsCategories: const StateStatus.loading(),
        )
    );
    final result=await _getMealsCategoriesUseCase.call();

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
              errorCategories: result.errorMessage,
              mealsCategories: StateStatus.failure(
                  ResponseException(message: result.errorMessage)),
            )
        );
        break;
    }
  }
}