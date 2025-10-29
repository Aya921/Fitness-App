import 'package:dio/dio.dart';
import 'package:fitness/core/constants/exception_constant.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/foods/api/client/api_services.dart';
import 'package:fitness/features/foods/api/data_source/food_remote_data_source_impl.dart';
import 'package:fitness/features/foods/api/models/meal_categories.dart';
import 'package:fitness/features/foods/api/models/meals_cattegories_response.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([FoodApiServices])
void main() {
  late MockFoodApiServices mockFoodApiServices;
  late FoodRemoteDataSourceImpl foodRemoteDataSourceImpl;
  setUpAll(() {
    mockFoodApiServices = MockFoodApiServices();
    foodRemoteDataSourceImpl = FoodRemoteDataSourceImpl
      (mockFoodApiServices);
  });
  group("Food Meals Categories", () {
    final successResponse = MealCaregoriesResponse(
      categories: [
        MealCategories(
          idCategory: "1",
          strCategory: "Beef",
          strCategoryThumb:
          "https://www.themealdb.com/images/category/beef.png",
          strCategoryDescription:
          "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]",
        ),
      ],
    );
    test("return SuccessResult when FoodApiServices success when get meals categories", () async {
      when(
        mockFoodApiServices.getMealsCategories(),
      ).thenAnswer((_) async => successResponse);
      final result = await foodRemoteDataSourceImpl.getMealsCategories();
      final meals = successResponse.categories?.map((e) => e.toEntity());
      expect(result, isA<SuccessResult>());
      expect((result as SuccessResult).successResult, meals);
      verify(mockFoodApiServices.getMealsCategories()).called(1);
    });
    test("return FailedResult when FoodApiServices failed when get meals categories", () async {
      final dioExeption = DioException(
        requestOptions: RequestOptions(path: "/"),
        type: DioExceptionType.connectionError,
      );
      when(mockFoodApiServices.getMealsCategories()).thenThrow(dioExeption);
      final result = await foodRemoteDataSourceImpl.getMealsCategories();
      expect(result, isA<FailedResult>());
      expect(
        (result as FailedResult).errorMessage,
        ExceptionConstants.connectionError,
      );
      verify(mockFoodApiServices.getMealsCategories()).called(1);
    });
    test(
      "return FailedResult when FoodApiServices failed on ResponseException when get meals categories ",
          () async {
        const responseExeption = ResponseException(
          message: "something went wrong",
        );
        when(
          mockFoodApiServices.getMealsCategories(),
        ).thenThrow(responseExeption);
        final result = await foodRemoteDataSourceImpl.getMealsCategories();
        expect(result, isA<FailedResult>());
        expect(
          (result as FailedResult).errorMessage,
          responseExeption.toString(),
        );
        verify(mockFoodApiServices.getMealsCategories()).called(1);
      },
    );
    test(
      "return FailedResult when FoodApiServices failed on Exception when get meals categories ",
          () async {
        final exception = Exception("throw Exception");
        when(mockFoodApiServices.getMealsCategories()).thenThrow(exception);
        final result = await foodRemoteDataSourceImpl.getMealsCategories();
        expect(result, isA<FailedResult>());
        expect((result as FailedResult).errorMessage, exception.toString());
        verify(mockFoodApiServices.getMealsCategories()).called(1);
      },
    );
  });

  group("Get Meals By Category", (){
    final fakeSuccessResponse=MealsCattegoriesResponse(
        meals: [
          Meals(
              strMeal: "15-minute chicken & halloumi burgers",
              strMealThumb: "https://www.themealdb.com/images/media/meals/vdwloy1713225718.jpg",
              idMeal: "53085"
          ),
          Meals(
              strMeal: "Ayam Percik",
              strMealThumb: "https://www.themealdb.com/images/media/meals/020z181619788503.jpg",
              idMeal: "53050"
          )
        ]
    );
    const category="Chicken";
    test("return SuccessResult when FoodApiServices success", ()async{

      when(mockFoodApiServices.getMealsByCategories(category)).thenAnswer((_)async=>
      fakeSuccessResponse);
      final result= await foodRemoteDataSourceImpl.getMealsByCategories(category);
      final meals=fakeSuccessResponse.meals?.map((e)=>e.toEntity()).toList();

      expect(result, isA<SuccessResult>());
      expect((result as SuccessResult).successResult,meals );
      verify(mockFoodApiServices.getMealsByCategories(category)).called(1);

    });
    test("return FailedResult when FoodApiServices failed on get Meals By Category on dioException", ()async{
      final dioException=DioException(requestOptions: RequestOptions(
          path: "/"
      ),type: DioExceptionType.cancel);
      when(mockFoodApiServices.getMealsByCategories(category)).thenThrow(dioException);
      final result= await foodRemoteDataSourceImpl.getMealsByCategories(category);


      expect(result, isA<FailedResult>());
      expect((result as FailedResult).errorMessage,ExceptionConstants.canceled );
      verify(mockFoodApiServices.getMealsByCategories(category)).called(1);

    });
    test("return FailedResult when FoodApiServices failed on get Meals By Category on Exception", ()async{
      final exception=Exception("Throw Exception");
      when(mockFoodApiServices.getMealsByCategories(category)).thenThrow(exception);
      final result= await foodRemoteDataSourceImpl.getMealsByCategories(category);


      expect(result, isA<FailedResult>());
      expect((result as FailedResult).errorMessage,exception.toString() );
      verify(mockFoodApiServices.getMealsByCategories(category)).called(1);
    });
    test("return FailedResult when FoodApiServices failed on get Meals By Category on ResponseException", ()async{
      const exception=ResponseException(message: "failed to load data");
      when(mockFoodApiServices.getMealsByCategories(category)).thenThrow(exception);
      final result= await foodRemoteDataSourceImpl.getMealsByCategories(category);


      expect(result, isA<FailedResult>());
      expect((result as FailedResult).errorMessage,exception.toString() );
      verify(mockFoodApiServices.getMealsByCategories(category)).called(1);
    });
  });
}