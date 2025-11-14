import 'package:fitness/features/foods/api/models/meals_cattegories_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Meals', () {
    const tIdMeal = '52772';
    const tStrMeal = 'Teriyaki Chicken Casserole';
    const tStrMealThumb = 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg';

    test('should create instance with all fields', () {
      // Arrange & Act
      final meal = Meals(
        idMeal: tIdMeal,
        strMeal: tStrMeal,
        strMealThumb: tStrMealThumb,
      );

      // Assert
      expect(meal.idMeal, tIdMeal);
      expect(meal.strMeal, tStrMeal);
      expect(meal.strMealThumb, tStrMealThumb);
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final meal = Meals();

      // Assert
      expect(meal.idMeal, isNull);
      expect(meal.strMeal, isNull);
      expect(meal.strMealThumb, isNull);
    });

    test('should create instance with partial fields', () {
      // Arrange & Act
      final meal = Meals(
        idMeal: tIdMeal,
        strMeal: tStrMeal,
      );

      // Assert
      expect(meal.idMeal, tIdMeal);
      expect(meal.strMeal, tStrMeal);
      expect(meal.strMealThumb, isNull);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final meal = Meals(
        idMeal: tIdMeal,
        strMeal: tStrMeal,
        strMealThumb: tStrMealThumb,
      );

      // Act
      final json = meal.toJson();

      // Assert
      expect(json['idMeal'], tIdMeal);
      expect(json['strMeal'], tStrMeal);
      expect(json['strMealThumb'], tStrMealThumb);
    });

    test('should serialize to JSON with null values', () {
      // Arrange
      final meal = Meals(
        idMeal: tIdMeal,
        strMeal: tStrMeal,
      );

      // Act
      final json = meal.toJson();

      // Assert
      expect(json['idMeal'], tIdMeal);
      expect(json['strMeal'], tStrMeal);
      expect(json.containsKey('strMealThumb'), isTrue);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'idMeal': tIdMeal,
        'strMeal': tStrMeal,
        'strMealThumb': tStrMealThumb,
      };

      // Act
      final meal = Meals.fromJson(json);

      // Assert
      expect(meal.idMeal, tIdMeal);
      expect(meal.strMeal, tStrMeal);
      expect(meal.strMealThumb, tStrMealThumb);
    });

    test('should deserialize from JSON with null values', () {
      // Arrange
      final json = {
        'idMeal': tIdMeal,
        'strMeal': null,
        'strMealThumb': null,
      };

      // Act
      final meal = Meals.fromJson(json);

      // Assert
      expect(meal.idMeal, tIdMeal);
      expect(meal.strMeal, isNull);
      expect(meal.strMealThumb, isNull);
    });

    test('should handle JSON serialization round-trip', () {
      // Arrange
      final original = Meals(
        idMeal: tIdMeal,
        strMeal: tStrMeal,
        strMealThumb: tStrMealThumb,
      );

      // Act
      final json = original.toJson();
      final deserialized = Meals.fromJson(json);

      // Assert
      expect(deserialized.idMeal, original.idMeal);
      expect(deserialized.strMeal, original.strMeal);
      expect(deserialized.strMealThumb, original.strMealThumb);
    });

    test('should convert model to entity with all fields', () {
      // Arrange
      final meal = Meals(
        idMeal: tIdMeal,
        strMeal: tStrMeal,
        strMealThumb: tStrMealThumb,
      );

      // Act
      final entity = meal.toEntity();

      // Assert
      expect(entity.idMeal, tIdMeal);
      expect(entity.strMeal, tStrMeal);
      expect(entity.strMealThumb, tStrMealThumb);
    });

    test('should convert model to entity with null fields', () {
      // Arrange
      final meal = Meals();

      // Act
      final entity = meal.toEntity();

      // Assert
      expect(entity.idMeal, isNull);
      expect(entity.strMeal, isNull);
      expect(entity.strMealThumb, isNull);
    });

    test('should handle empty strings', () {
      // Arrange
      final meal = Meals(
        idMeal: '',
        strMeal: '',
        strMealThumb: '',
      );

      // Act
      final json = meal.toJson();
      final deserialized = Meals.fromJson(json);

      // Assert
      expect(deserialized.idMeal, '');
      expect(deserialized.strMeal, '');
      expect(deserialized.strMealThumb, '');
    });

    test('should handle special characters in meal name', () {
      // Arrange
      const specialMealName = 'Chicken & Rice with Jalapeño';
      final meal = Meals(
        idMeal: tIdMeal,
        strMeal: specialMealName,
        strMealThumb: tStrMealThumb,
      );

      // Act
      final json = meal.toJson();
      final deserialized = Meals.fromJson(json);

      // Assert
      expect(deserialized.strMeal, specialMealName);
    });

    test('should handle long URL in strMealThumb', () {
      // Arrange
      const longUrl = 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg?quality=high&resolution=4k';
      final meal = Meals(
        idMeal: tIdMeal,
        strMeal: tStrMeal,
        strMealThumb: longUrl,
      );

      // Act
      final json = meal.toJson();
      final deserialized = Meals.fromJson(json);

      // Assert
      expect(deserialized.strMealThumb, longUrl);
    });
  });

  group('MealsCattegoriesResponse', () {
    final tMeal1 = Meals(
      idMeal: '52772',
      strMeal: 'Teriyaki Chicken Casserole',
      strMealThumb: 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
    );

    final tMeal2 = Meals(
      idMeal: '52773',
      strMeal: 'Honey Teriyaki Salmon',
      strMealThumb: 'https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg',
    );

    test('should create instance with meals list', () {
      // Arrange & Act
      final response = MealsCattegoriesResponse(
        meals: [tMeal1, tMeal2],
      );

      // Assert
      expect(response.meals, isNotNull);
      expect(response.meals?.length, 2);
      expect(response.meals?[0].idMeal, '52772');
      expect(response.meals?[1].idMeal, '52773');
    });

    test('should create instance with null meals', () {
      // Arrange & Act
      final response = MealsCattegoriesResponse();

      // Assert
      expect(response.meals, isNull);
    });

    test('should create instance with empty meals list', () {
      // Arrange & Act
      final response = MealsCattegoriesResponse(meals: []);

      // Assert
      expect(response.meals, isNotNull);
      expect(response.meals?.length, 0);
    });

    test('should serialize to JSON with null meals', () {
      // Arrange
      final response = MealsCattegoriesResponse();

      // Act
      final json = response.toJson();

      // Assert
      expect(json.containsKey('meals'), isTrue);
      expect(json['meals'], isNull);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'meals': [
          {
            'idMeal': '52772',
            'strMeal': 'Teriyaki Chicken Casserole',
            'strMealThumb': 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
          },
          {
            'idMeal': '52773',
            'strMeal': 'Honey Teriyaki Salmon',
            'strMealThumb': 'https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg',
          },
        ],
      };

      // Act
      final response = MealsCattegoriesResponse.fromJson(json);

      // Assert
      expect(response.meals, isNotNull);
      expect(response.meals?.length, 2);
      expect(response.meals?[0].idMeal, '52772');
      expect(response.meals?[0].strMeal, 'Teriyaki Chicken Casserole');
      expect(response.meals?[1].idMeal, '52773');
      expect(response.meals?[1].strMeal, 'Honey Teriyaki Salmon');
    });

    test('should deserialize from JSON with empty meals list', () {
      // Arrange
      final json = {
        'meals': [],
      };

      // Act
      final response = MealsCattegoriesResponse.fromJson(json);

      // Assert
      expect(response.meals, isNotNull);
      expect(response.meals?.length, 0);
    });

    test('should deserialize from JSON with null meals', () {
      // Arrange
      final json = {
        'meals': null,
      };

      // Act
      final response = MealsCattegoriesResponse.fromJson(json);

      // Assert
      expect(response.meals, isNull);
    });


    test('should convert all meals to entities', () {
      // Arrange
      final response = MealsCattegoriesResponse(
        meals: [tMeal1, tMeal2],
      );

      // Act
      final entities = response.meals?.map((meal) => meal.toEntity()).toList();

      // Assert
      expect(entities?.length, 2);
      expect(entities?[0].idMeal, '52772');
      expect(entities?[0].strMeal, 'Teriyaki Chicken Casserole');
      expect(entities?[1].idMeal, '52773');
      expect(entities?[1].strMeal, 'Honey Teriyaki Salmon');
    });

    test('should handle meals with missing thumbnails', () {
      // Arrange
      final json = {
        'meals': [
          {
            'idMeal': '52772',
            'strMeal': 'Teriyaki Chicken Casserole',
            'strMealThumb': null,
          },
        ],
      };

      // Act
      final response = MealsCattegoriesResponse.fromJson(json);

      // Assert
      expect(response.meals?[0].idMeal, '52772');
      expect(response.meals?[0].strMeal, 'Teriyaki Chicken Casserole');
      expect(response.meals?[0].strMealThumb, isNull);
    });

    test('should handle meals with partial data', () {
      // Arrange
      final json = {
        'meals': [
          {
            'idMeal': '52772',
          },
          {
            'strMeal': 'Honey Teriyaki Salmon',
          },
        ],
      };

      // Act
      final response = MealsCattegoriesResponse.fromJson(json);

      // Assert
      expect(response.meals?.length, 2);
      expect(response.meals?[0].idMeal, '52772');
      expect(response.meals?[0].strMeal, isNull);
      expect(response.meals?[1].idMeal, isNull);
      expect(response.meals?[1].strMeal, 'Honey Teriyaki Salmon');
    });
  });
}