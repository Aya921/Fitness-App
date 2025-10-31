import 'meal_info.dart';
import 'meal_media.dart';


class MealEntity {
  final String idMeal;
  final String strMeal;
  final MealInfo info;
  final String strInstructions;
  final MealMedia media;
  final List<String> ingredients;
  final List<String> measures;

  MealEntity({
    required this.idMeal,
    required this.strMeal,
    required this.info,
    required this.strInstructions,
    required this.media,
    required this.ingredients,
    required this.measures,
  });



  
}
