import 'package:dio/dio.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/error/api_error.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/remote/data_source_imp/details_food_data_souce_imp.dart';
import 'package:fitness/features/meal_details/remote/details_food_api/client/details_food_api_service.dart';
import 'package:fitness/features/meal_details/remote/details_food_api/models/meal_model.dart';
import 'package:fitness/features/meal_details/remote/details_food_api/models/meal_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'details_food_data_souce_imp_test.mocks.dart';

@GenerateMocks([DetailsFoodApiService])
void main() {
  late DetailsFoodDataSourceImp dataSource;
  late MockDetailsFoodApiService mockApiService;

  setUp(() {
    mockApiService = MockDetailsFoodApiService();
    dataSource = DetailsFoodDataSourceImp(mockApiService);
  });

  group('getMealDetails()', () {
    const mealId = '12345';

    final mealModel = MealModel(
      idMeal: mealId,
      strMeal: 'Pizza',
      strMealAlternate: 'Italian Pizza',
      strCategory: 'Fast Food',
      strArea: 'Italy',
      strInstructions: 'Bake for 20 minutes.',
      strMealThumb: 'thumb.jpg',
      strTags: 'Dinner,Cheese',
      strYoutube: 'https://www.youtube.com/watch?v=abcd1234',
      strSource: 'source.com',
      strImageSource: 'imgsource.com',
      strCreativeCommonsConfirmed: 'Yes',
      dateModified: '2025-10-30',
      strIngredient1: 'Flour',
      strIngredient2: 'Cheese',
      strMeasure1: '200g',
      strMeasure2: '100g',
    );

    final mealResponseModel = MealResponseModel(meals: [mealModel]);
    final mealEntity = mealModel.mealModelToEntity();

    test(
      'should return SuccessResult with MealResponseEntity when API call succeeds',
      () async {
        when(
          mockApiService.getMealDetails(mealId),
        ).thenAnswer((_) async => mealResponseModel);

        final result = await dataSource.getMealDetails(mealId: mealId);

        expect(result, isA<SuccessResult<MealResponseEntity>>());
        final success = result as SuccessResult<MealResponseEntity>;
        expect(
          success.successResult.meal.first.idMeal,
          equals(mealEntity.idMeal),
        );
        verify(mockApiService.getMealDetails(mealId)).called(1);
      },
    );

    test(
      'should return FailedResult when API call throws an exception',

      () async {
        when(
          mockApiService.getMealDetails(mealId),
        ).thenThrow(Exception('Error'));

        final res = await dataSource.getMealDetails(mealId: mealId);

        expect(res, isA<FailedResult>());
        final acResult = res as FailedResult<void>;
        expect(acResult.errorMessage.toString(), "Exception: Error");
        verify(mockApiService.getMealDetails(mealId)).called(1);
      },
    );

    test("resetPassword returns FailedResult<void> on DioException", () async {
      final dioEx = DioException(
        requestOptions: RequestOptions(path: ''),
        message: "dio Exception",
      );
      when(mockApiService.getMealDetails(any)).thenThrow(dioEx);

      final res = await dataSource.getMealDetails(mealId: mealId);

      expect(res, isA<FailedResult<void>>());
      final acResult = res as FailedResult<void>;
      expect(acResult.errorMessage, ServerFailure.fromDioError(dioEx).error);
      verify(mockApiService.getMealDetails(any)).called(1);
    });
  });

  group('convertIdToVideo()', () {
    test('should return SuccessResult with valid YouTube ID', () async {
      const videoUrl =
          'https://www.youtube.com/watch?v=Rf46BrXgxbQ&list=PLyhJeMedQd9QLVWS-hQtfQvlTuJLQVt6v&index=4';

      final result = await dataSource.convertIdToVideo(videoUrl);

      expect(result, isA<SuccessResult<String>>());
      final success = result as SuccessResult<String>;
      expect(success.successResult, equals('Rf46BrXgxbQ'));
    });

    test('should return FailedResult when URL is invalid', () async {
      const invalidUrl = 'https://example.com/invalid';
      final result = await dataSource.convertIdToVideo(invalidUrl);
      expect(result, isA<FailedResult>());
      final acRes = result as FailedResult;
      expect(acRes.errorMessage, Constants.invalidUrl);
    });
  });
}
