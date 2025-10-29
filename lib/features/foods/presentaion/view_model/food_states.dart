import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';

import '../../domain/entities/meals_by_category.dart';
import '../../domain/entities/meals_categories.dart';

class FoodStates extends Equatable {
  final StateStatus<List<MealCategoryEntity>> mealsCategories;
  final String? errorCategories;
  final StateStatus<List<MealsByCategory>> mealsByCategorieStatus;
  final String? errorMealsByCategories;

  const FoodStates({
    this.mealsCategories = const StateStatus.initial(),
    this.errorCategories,
    this.mealsByCategorieStatus = const StateStatus.initial(),
    this.errorMealsByCategories,
  });

  FoodStates copyWith({
    StateStatus<List<MealCategoryEntity>>? mealsCategories,
    String? errorCategories,
    StateStatus<List<MealsByCategory>>? mealsByCategorieStatus,
    String? errorMealsByCategories,
  }) {
    return FoodStates(
      mealsCategories: mealsCategories ?? this.mealsCategories,
      errorCategories: errorCategories ?? this.errorCategories,
      mealsByCategorieStatus:
      mealsByCategorieStatus ?? this.mealsByCategorieStatus,
      errorMealsByCategories:
      errorMealsByCategories ?? this.errorMealsByCategories,
    );
  }

  @override
  List<Object?> get props => [
    mealsCategories,
    errorCategories,
    mealsByCategorieStatus,
    errorMealsByCategories,
  ];
}