import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';

import '../../domain/entities/meals_categories.dart';

class FoodStates extends Equatable{
final StateStatus<List<MealCategoryEntity>> mealsCategories;
final String? errorCategories;
const FoodStates(
{
  this.mealsCategories=const StateStatus.initial(),
  this.errorCategories
}
    );
FoodStates copyWith(
    {
       StateStatus<List<MealCategoryEntity>>? mealsCategories,
       String? errorCategories,
    }
    ){
return FoodStates(
  mealsCategories: mealsCategories??this.mealsCategories,
  errorCategories: errorCategories??this.errorCategories
);
}
  @override
  List<Object?> get props => [
    mealsCategories,
    errorCategories
  ];

}