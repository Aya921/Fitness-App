import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/data/details_food_data_source/details_food_data_source.dart';
import 'package:fitness/features/meal_details/data/details_food_repo_imp/details_food_repo_imp.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_entity.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_info.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_media.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'details_food_repo_imp_test.mocks.dart';

@GenerateMocks([DetailsFoodDataSource])
void main() {
  late DetailsFoodRepoImp detailsFoodRepoImp;
  late MockDetailsFoodDataSource mockDetailsFoodDataSource;

  setUp(() {
    mockDetailsFoodDataSource = MockDetailsFoodDataSource();
    detailsFoodRepoImp = DetailsFoodRepoImp(mockDetailsFoodDataSource);
  });

  group('convertIdToVideo', () {
    test('returns SuccessResult when dataSource returns SuccessResult', () async {
      const videoUrl =
          'https://www.youtube.com/watch?v=Rf46BrXgxbQ&list=PLyhJeMedQd9QLVWS-hQtfQvlTuJLQVt6v&index=4';
      const expectedId = 'Rf46BrXgxbQ';
      final mockResult = SuccessResult<String>(expectedId);

      provideDummy<Result<String>>(mockResult);
      when(
        mockDetailsFoodDataSource.convertIdToVideo(videoUrl),
      ).thenAnswer((_) async => mockResult);

      final result = await detailsFoodRepoImp.convertIdToVideo(videoUrl);

      expect(result, isA<SuccessResult<String>>());
      final success = result as SuccessResult<String>;
      expect(success.successResult, expectedId);
      verify(mockDetailsFoodDataSource.convertIdToVideo(videoUrl)).called(1);
    });

    test('returns FailedResult when dataSource throws exception', () async {
      const videoUrl = 'invalid_url';

      final mockResult = FailedResult<String>(Constants.invalidUrl);

      provideDummy<Result<String>>(mockResult);
      when(
        mockDetailsFoodDataSource.convertIdToVideo(videoUrl),
      ).thenAnswer((_) async => mockResult);

      final result = await detailsFoodRepoImp.convertIdToVideo(videoUrl);

      expect(result, isA<FailedResult<String>>());
      final fail = result as FailedResult<String>;
      expect(fail.errorMessage, Constants.invalidUrl);
      verify(mockDetailsFoodDataSource.convertIdToVideo(videoUrl)).called(1);
    });
  });

  group('getMealDetails', () {
    test('returns SuccessResult when dataSource returns SuccessResult', () async {
      const mealId = '1234';
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
     
     
      final mockResult = SuccessResult<MealResponseEntity>(mealResponse);

      provideDummy<Result<MealResponseEntity>>(mockResult);
      when(
        mockDetailsFoodDataSource.getMealDetails(mealId: mealId),
      ).thenAnswer((_) async => mockResult);

      final result = await detailsFoodRepoImp.getMealDetails(mealId: mealId);

      // Assert
      expect(result, isA<SuccessResult<MealResponseEntity>>());
      final success = result as SuccessResult<MealResponseEntity>;
      expect(success.successResult, mealResponse);
      verify(
        mockDetailsFoodDataSource.getMealDetails(mealId: mealId),
      ).called(1);
    });

    test('returns FailedResult when dataSource throws Exception', () async {
      const mealId = '1234';
      final mockResult = FailedResult<MealResponseEntity>("error");

      provideDummy<Result<MealResponseEntity>>(mockResult);
      when(
        mockDetailsFoodDataSource.getMealDetails(mealId: mealId),
      ).thenAnswer((_) async => mockResult);


      final result = await detailsFoodRepoImp.getMealDetails(mealId: mealId);

      expect(result, isA<FailedResult<MealResponseEntity>>());
      final fail = result as FailedResult<MealResponseEntity>;
      expect(fail.errorMessage.toString(), contains('error'));
      verify(
        mockDetailsFoodDataSource.getMealDetails(mealId: mealId),
      ).called(1);
    });
  });
}
