import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/api/models/explore_models/meals_categories_model/meals_categories_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meals_categories_response.g.dart';

@JsonSerializable()
class MealsCategoriesResponse extends Equatable {
  @JsonKey(name: "categories")
  final List<MealsCategoriesModel>? categories;

  const MealsCategoriesResponse({
    this.categories,
  });

  factory MealsCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsCategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsCategoriesResponseToJson(this);
  }

  @override
  List<Object?> get props => [categories];
}