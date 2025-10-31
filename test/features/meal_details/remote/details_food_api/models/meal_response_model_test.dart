import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/meal_details/remote/details_food_api/models/meal_model.dart';
import 'package:fitness/features/meal_details/remote/details_food_api/models/meal_response_model.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_entity.dart';

void main() {
  group('MealResponseModel.toEntity()', () {
    test('should correctly convert a valid MealResponseModel to MealResponseEntity', () {
    
      final mealModel = MealModel(
        idMeal: '1',
        strMeal: 'Pasta',
        strCategory: 'Italian',
        strArea: 'Europe',
        strInstructions: 'Boil pasta and mix with sauce',
        strMealThumb: 'thumb.jpg',
        strTags: 'Dinner,Quick',
        strYoutube: 'youtube.com',
        strSource: 'source.com',
      );

      final responseModel = MealResponseModel(meals: [mealModel]);

     
      final entity = responseModel.toEntity();

     
      expect(entity, isA<MealResponseEntity>());
      expect(entity.meal.length, 1);
      expect(entity.meal.first, isA<MealEntity>());
      expect(entity.meal.first.strMeal, 'Pasta');
      expect(entity.meal.first.info.strCategory, 'Italian');
      expect(entity.meal.first.info.strTags, ['Dinner', 'Quick']);
    });

    test('should handle empty meal list correctly', () {
      
      final responseModel = MealResponseModel(meals: []);

  
      final entity = responseModel.toEntity();

      expect(entity, isA<MealResponseEntity>());
      expect(entity.meal, isEmpty);
    });
  });
}
