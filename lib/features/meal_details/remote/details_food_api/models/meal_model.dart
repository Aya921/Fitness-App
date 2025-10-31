import 'package:fitness/features/meal_details/domain/entity/details_food/meal_entity.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_info.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel {
  final String idMeal;
  final String strMeal;
  final String? strMealAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final String? strSource;
  final String? strImageSource;
  final String? strCreativeCommonsConfirmed;
  final String? dateModified;

  // Ingredients (1–20)
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strIngredient16;
  final String? strIngredient17;
  final String? strIngredient18;
  final String? strIngredient19;
  final String? strIngredient20;

  // Measures (1–20)
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;
  final String? strMeasure16;
  final String? strMeasure17;
  final String? strMeasure18;
  final String? strMeasure19;
  final String? strMeasure20;

  MealModel({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);

  MealEntity mealModelToEntity() {
    final ingredients = [
      strIngredient1 ?? '',
      strIngredient2 ?? '',
      strIngredient3 ?? '',
      strIngredient4 ?? '',
      strIngredient5 ?? '',
      strIngredient6 ?? '',
      strIngredient7 ?? '',
      strIngredient8 ?? '',
      strIngredient9 ?? '',
      strIngredient10 ?? '',
      strIngredient11 ?? '',
      strIngredient12 ?? '',
      strIngredient13 ?? '',
      strIngredient14 ?? '',
      strIngredient15 ?? '',
      strIngredient16 ?? '',
      strIngredient17 ?? '',
      strIngredient18 ?? '',
      strIngredient19 ?? '',
      strIngredient20 ?? '',
    ];

    final measures = [
      strMeasure1 ?? '',
      strMeasure2 ?? '',
      strMeasure3 ?? '',
      strMeasure4 ?? '',
      strMeasure5 ?? '',
      strMeasure6 ?? '',
      strMeasure7 ?? '',
      strMeasure8 ?? '',
      strMeasure9 ?? '',
      strMeasure10 ?? '',
      strMeasure11 ?? '',
      strMeasure12 ?? '',
      strMeasure13 ?? '',
      strMeasure14 ?? '',
      strMeasure15 ?? '',
      strMeasure16 ?? '',
      strMeasure17 ?? '',
      strMeasure18 ?? '',
      strMeasure19 ?? '',
      strMeasure20 ?? '',
    ];
    final tags = (strTags ?? '')
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
    return MealEntity(
      idMeal: idMeal,
      strMeal: strMeal,
      strInstructions: strInstructions ?? '',
      info: MealInfo(
        strMealAlternate: strMealAlternate ?? '',
        strCategory: strCategory ?? '',
        strArea: strArea ?? '',
        strTags: tags,
        dateModified: dateModified ?? '',
        strSource: strSource ?? '',
        strCreativeCommonsConfirmed: strCreativeCommonsConfirmed ?? '',
      ),
      media: MealMedia(
        strMealThumb: strMealThumb ?? '',
        strYoutube: strYoutube ?? '',
        strImageSource: strImageSource ?? '',
      ),
      ingredients: ingredients,
      measures: measures,
    );
  }
}
