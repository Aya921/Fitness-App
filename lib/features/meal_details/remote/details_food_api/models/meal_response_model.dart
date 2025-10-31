import 'package:fitness/features/meal_details/remote/details_food_api/models/meal_model.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MealResponseModel {
  final List<MealModel> meals;

  MealResponseModel({required this.meals});

  factory MealResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MealResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealResponseModelToJson(this);

  MealResponseEntity toEntity() {
    return MealResponseEntity(meal: meals.map((meal) =>meal.mealModelToEntity()).toList());
  }
}
