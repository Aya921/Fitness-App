import 'package:fitness/features/food/domain/entities/meals_by_category.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/json_serializable_constants.dart';

part 'meals_cattegories_response.g.dart';

@JsonSerializable()
class MealsCattegoriesResponse {
  @JsonKey(name: JsonSerializableConstants.meals)
  final List<Meals>? meals;

  MealsCattegoriesResponse ({
    this.meals,
  });

  factory MealsCattegoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsCattegoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsCattegoriesResponseToJson(this);
  }
}

@JsonSerializable()
class Meals {
  @JsonKey(name: JsonSerializableConstants.strMeal)
  final String? strMeal;
  @JsonKey(name: JsonSerializableConstants.strMealThumb)
  final String? strMealThumb;
  @JsonKey(name: JsonSerializableConstants.idMeal)
  final String? idMeal;

  Meals ({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  factory Meals.fromJson(Map<String, dynamic> json) {
    return _$MealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsToJson(this);
  }
  MealsByCategory toEntity(){
    return MealsByCategory(
      idMeal: idMeal,
      strMeal: strMeal,
      strMealThumb: strMealThumb
    );
  }
}


