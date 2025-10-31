import 'package:fitness/features/meal_details/remote/details_food_api/models/meal_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_entity.dart';

void main() {
  group('MealModel.mealModelToEntity()', () {
    test('should convert MealModel with valid data correctly', () {
      // Arrange
      final model = MealModel(
        idMeal: '123',
        strMeal: 'Pizza',
        strMealAlternate: 'Cheese Pizza',
        strCategory: 'Fast Food',
        strArea: 'Italian',
        strInstructions: 'Bake it in oven.',
        strMealThumb: 'thumb.jpg',
        strTags: 'Dinner,Cheese',
        strYoutube: 'youtube.com',
        strSource: 'source.com',
        strImageSource: 'imgsource.jpg',
        strCreativeCommonsConfirmed: 'Yes',
        dateModified: '2023-01-01',
        strIngredient1: 'Cheese',
        strIngredient2: 'Dough',
        strMeasure1: '200g',
        strMeasure2: '1 piece',
      );

      // Act
      final entity = model.mealModelToEntity();

      // Assert
      expect(entity, isA<MealEntity>());
      expect(entity.idMeal, '123');
      expect(entity.strMeal, 'Pizza');
      expect(entity.strInstructions, 'Bake it in oven.');
      expect(entity.info.strCategory, 'Fast Food');
      expect(entity.info.strArea, 'Italian');
      expect(entity.media.strMealThumb, 'thumb.jpg');
      expect(entity.ingredients.first, 'Cheese');
      expect(entity.measures.first, '200g');
      expect(entity.info.strTags, ['Dinner', 'Cheese']);
    });

    test('should handle null and empty fields gracefully', () {
      // Arrange
      final model = MealModel(
        idMeal: '001',
        strMeal: 'Unknown',
        strMealAlternate: null,
        strCategory: null,
        strArea: null,
        strInstructions: null,
        strMealThumb: null,
        strTags: null,
        strYoutube: null,
        strSource: null,
        strImageSource: null,
        strCreativeCommonsConfirmed: null,
        dateModified: null,
      );

      // Act
      final entity = model.mealModelToEntity();

      // Assert
      expect(entity, isA<MealEntity>());
      expect(entity.idMeal, '001');
      expect(entity.strMeal, 'Unknown');
      expect(entity.strInstructions, isEmpty);
      expect(entity.info.strCategory, isEmpty);
      expect(entity.media.strMealThumb, isEmpty);
      expect(entity.ingredients, everyElement(isA<String>()));
      expect(entity.measures, everyElement(isA<String>()));
      expect(entity.info.strTags, isEmpty);
    });
  });
}
