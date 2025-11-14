import 'package:fitness/features/foods/api/models/meal_categories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MealCategories', () {
    const tIdCategory = '1';
    const tStrCategory = 'Beef';
    const tStrCategoryThumb = 'https://example.com/beef.jpg';
    const tStrCategoryDescription = 'Beef is the culinary name for meat from cattle';

    test('should create instance with all fields', () {
      // Arrange & Act
      final category = MealCategories(
        idCategory: tIdCategory,
        strCategory: tStrCategory,
        strCategoryThumb: tStrCategoryThumb,
        strCategoryDescription: tStrCategoryDescription,
      );

      // Assert
      expect(category.idCategory, tIdCategory);
      expect(category.strCategory, tStrCategory);
      expect(category.strCategoryThumb, tStrCategoryThumb);
      expect(category.strCategoryDescription, tStrCategoryDescription);
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final category = MealCategories();

      // Assert
      expect(category.idCategory, isNull);
      expect(category.strCategory, isNull);
      expect(category.strCategoryThumb, isNull);
      expect(category.strCategoryDescription, isNull);
    });

    test('should create instance with partial fields', () {
      // Arrange & Act
      final category = MealCategories(
        idCategory: tIdCategory,
        strCategory: tStrCategory,
      );

      // Assert
      expect(category.idCategory, tIdCategory);
      expect(category.strCategory, tStrCategory);
      expect(category.strCategoryThumb, isNull);
      expect(category.strCategoryDescription, isNull);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final category = MealCategories(
        idCategory: tIdCategory,
        strCategory: tStrCategory,
        strCategoryThumb: tStrCategoryThumb,
        strCategoryDescription: tStrCategoryDescription,
      );

      // Act
      final json = category.toJson();

      // Assert
      expect(json['idCategory'], tIdCategory);
      expect(json['strCategory'], tStrCategory);
      expect(json['strCategoryThumb'], tStrCategoryThumb);
      expect(json['strCategoryDescription'], tStrCategoryDescription);
    });

    test('should serialize to JSON with null values', () {
      // Arrange
      final category = MealCategories(
        idCategory: tIdCategory,
        strCategory: tStrCategory,
      );

      // Act
      final json = category.toJson();

      // Assert
      expect(json['idCategory'], tIdCategory);
      expect(json['strCategory'], tStrCategory);
      expect(json.containsKey('strCategoryThumb'), isTrue);
      expect(json.containsKey('strCategoryDescription'), isTrue);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'idCategory': tIdCategory,
        'strCategory': tStrCategory,
        'strCategoryThumb': tStrCategoryThumb,
        'strCategoryDescription': tStrCategoryDescription,
      };

      // Act
      final category = MealCategories.fromJson(json);

      // Assert
      expect(category.idCategory, tIdCategory);
      expect(category.strCategory, tStrCategory);
      expect(category.strCategoryThumb, tStrCategoryThumb);
      expect(category.strCategoryDescription, tStrCategoryDescription);
    });

    test('should deserialize from JSON with null values', () {
      // Arrange
      final json = {
        'idCategory': tIdCategory,
        'strCategory': null,
        'strCategoryThumb': null,
        'strCategoryDescription': null,
      };

      // Act
      final category = MealCategories.fromJson(json);

      // Assert
      expect(category.idCategory, tIdCategory);
      expect(category.strCategory, isNull);
      expect(category.strCategoryThumb, isNull);
      expect(category.strCategoryDescription, isNull);
    });

    test('should handle JSON serialization round-trip', () {
      // Arrange
      final original = MealCategories(
        idCategory: tIdCategory,
        strCategory: tStrCategory,
        strCategoryThumb: tStrCategoryThumb,
        strCategoryDescription: tStrCategoryDescription,
      );

      // Act
      final json = original.toJson();
      final deserialized = MealCategories.fromJson(json);

      // Assert
      expect(deserialized.idCategory, original.idCategory);
      expect(deserialized.strCategory, original.strCategory);
      expect(deserialized.strCategoryThumb, original.strCategoryThumb);
      expect(deserialized.strCategoryDescription, original.strCategoryDescription);
    });

    test('should convert model to entity with all fields', () {
      // Arrange
      final category = MealCategories(
        idCategory: tIdCategory,
        strCategory: tStrCategory,
        strCategoryThumb: tStrCategoryThumb,
        strCategoryDescription: tStrCategoryDescription,
      );

      // Act
      final entity = category.toEntity();

      // Assert
      expect(entity.idCategory, tIdCategory);
      expect(entity.strCategory, tStrCategory);
      expect(entity.strCategoryThumb, tStrCategoryThumb);
      expect(entity.strCategoryDescription, tStrCategoryDescription);
    });

    test('should handle empty strings', () {
      // Arrange
      final category = MealCategories(
        idCategory: '',
        strCategory: '',
        strCategoryThumb: '',
        strCategoryDescription: '',
      );

      // Act
      final json = category.toJson();
      final deserialized = MealCategories.fromJson(json);

      // Assert
      expect(deserialized.idCategory, '');
      expect(deserialized.strCategory, '');
      expect(deserialized.strCategoryThumb, '');
      expect(deserialized.strCategoryDescription, '');
    });

    test('should handle special characters in description', () {
      // Arrange
      const specialDescription = 'Description with special chars: @#\$%^&*()';
      final category = MealCategories(
        idCategory: tIdCategory,
        strCategory: tStrCategory,
        strCategoryThumb: tStrCategoryThumb,
        strCategoryDescription: specialDescription,
      );

      // Act
      final json = category.toJson();
      final deserialized = MealCategories.fromJson(json);

      // Assert
      expect(deserialized.strCategoryDescription, specialDescription);
    });

  });

  group('MealCaregoriesResponse', () {
    final tCategory1 = MealCategories(
      idCategory: '1',
      strCategory: 'Beef',
      strCategoryThumb: 'https://example.com/beef.jpg',
      strCategoryDescription: 'Beef description',
    );

    final tCategory2 = MealCategories(
      idCategory: '2',
      strCategory: 'Chicken',
      strCategoryThumb: 'https://example.com/chicken.jpg',
      strCategoryDescription: 'Chicken description',
    );

    test('should create instance with categories list', () {
      // Arrange & Act
      final response = MealCaregoriesResponse(
        categories: [tCategory1, tCategory2],
      );

      // Assert
      expect(response.categories, isNotNull);
      expect(response.categories?.length, 2);
      expect(response.categories?[0].idCategory, '1');
      expect(response.categories?[1].idCategory, '2');
    });

    test('should create instance with null categories', () {
      // Arrange & Act
      final response = MealCaregoriesResponse();

      // Assert
      expect(response.categories, isNull);
    });

    test('should create instance with empty categories list', () {
      // Arrange & Act
      final response = MealCaregoriesResponse(categories: []);

      // Assert
      expect(response.categories, isNotNull);
      expect(response.categories?.length, 0);
    });


    test('should serialize to JSON with null categories', () {
      // Arrange
      final response = MealCaregoriesResponse();

      // Act
      final json = response.toJson();

      // Assert
      expect(json.containsKey('categories'), isTrue);
      expect(json['categories'], isNull);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'categories': [
          {
            'idCategory': '1',
            'strCategory': 'Beef',
            'strCategoryThumb': 'https://example.com/beef.jpg',
            'strCategoryDescription': 'Beef description',
          },
          {
            'idCategory': '2',
            'strCategory': 'Chicken',
            'strCategoryThumb': 'https://example.com/chicken.jpg',
            'strCategoryDescription': 'Chicken description',
          },
        ],
      };

      // Act
      final response = MealCaregoriesResponse.fromJson(json);

      // Assert
      expect(response.categories, isNotNull);
      expect(response.categories?.length, 2);
      expect(response.categories?[0].idCategory, '1');
      expect(response.categories?[0].strCategory, 'Beef');
      expect(response.categories?[1].idCategory, '2');
      expect(response.categories?[1].strCategory, 'Chicken');
    });

    test('should deserialize from JSON with empty categories list', () {
      // Arrange
      final json = {
        'categories': [],
      };

      // Act
      final response = MealCaregoriesResponse.fromJson(json);

      // Assert
      expect(response.categories, isNotNull);
      expect(response.categories?.length, 0);
    });

    test('should deserialize from JSON with null categories', () {
      // Arrange
      final json = {
        'categories': null,
      };

      // Act
      final response = MealCaregoriesResponse.fromJson(json);

      // Assert
      expect(response.categories, isNull);
    });


  });
}