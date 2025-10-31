import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_entity.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_info.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_media.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/domain/repository/details_food_repo.dart';
import 'package:fitness/features/meal_details/domain/usecase/get_meal_details_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_meal_details_usecase_test.mocks.dart';

@GenerateMocks([DetailsFoodRepo])
void main() {
  late MockDetailsFoodRepo mockDetailsFoodRepo;
  late GetMealDetailsUsecase getMealDetailsUsecase;

  setUp(() {
    mockDetailsFoodRepo = MockDetailsFoodRepo();
    getMealDetailsUsecase = GetMealDetailsUsecase(mockDetailsFoodRepo);
  });

  group('GetMealDetailsUsecase', () {
    const mealId = '12345';
    final mealResponse = MealResponseEntity(
        meal: [
          MealEntity(
            strMeal: 'Pizza',
            strInstructions: 'Bake it',
            media: MealMedia(
              strMealThumb:
                  'https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg',
              strYoutube: 'https://www.youtube.com/watch?v=N4EdUt0Ou48',
              strImageSource: '',
            ),
            info: MealInfo(
              strTags: ['Italian, FastFood'],
              strMealAlternate: '',
              strCategory: '',
              strArea: '',
              dateModified: '',
              strSource: '',
              strCreativeCommonsConfirmed: '',
            ),
            ingredients: ['Cheese', 'Tomato'],
            measures: ['100g', '50g'],
            idMeal: '',
          ),
        ],
      );
     

    test('should return SuccessResult when repo call succeeds', () async {
      final mockResult = SuccessResult<MealResponseEntity>(mealResponse);
      provideDummy<Result<MealResponseEntity>>(mockResult);

      when(mockDetailsFoodRepo.getMealDetails(mealId: mealId))
          .thenAnswer((_) async => mockResult);

      final result = await getMealDetailsUsecase.getMealDetails(mealId: mealId);

      expect(result, isA<SuccessResult<MealResponseEntity>>());
      verify(mockDetailsFoodRepo.getMealDetails(mealId: mealId)).called(1);
    });

    test('should return FailedResult when repo call fails', () async {
      final mockResult = FailedResult<MealResponseEntity>('Failed to fetch meal details');
      provideDummy<Result<MealResponseEntity>>(mockResult);

      when(mockDetailsFoodRepo.getMealDetails(mealId: mealId))
          .thenAnswer((_) async => mockResult);

      final result = await getMealDetailsUsecase.getMealDetails(mealId: mealId);

      expect(result, isA<FailedResult<MealResponseEntity>>());
      verify(mockDetailsFoodRepo.getMealDetails(mealId: mealId)).called(1);
    });
  });
}
