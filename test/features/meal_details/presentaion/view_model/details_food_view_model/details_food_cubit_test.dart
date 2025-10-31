import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/domain/usecase/get_meal_details_usecase.dart';
import 'package:fitness/features/meal_details/domain/usecase/get_video_usecase.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_cubit.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_event.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'details_food_cubit_test.mocks.dart';

@GenerateMocks([GetVideoUsecase, GetMealDetailsUsecase])
void main() {
  late DetailsFoodCubit detailsFoodCubit;
  late MockGetVideoUsecase mockGetVideoUsecase;
  late MockGetMealDetailsUsecase mockGetMealDetailsUsecase;

  setUp(() {
    mockGetVideoUsecase = MockGetVideoUsecase();
    mockGetMealDetailsUsecase = MockGetMealDetailsUsecase();
    detailsFoodCubit = DetailsFoodCubit(
      mockGetVideoUsecase,
      mockGetMealDetailsUsecase,
    );
  });

  // -------------------------------------------------------------------
  group("test _getVideo fn", () {
    const videoUrl = "https://youtube.com/watch?v=abcd1234";
    const videoId = "abcd1234";

    blocTest<DetailsFoodCubit, DetailsFoodState>(
      "should emit success state when SuccessResult back",
      build: () {
        final mockResult = SuccessResult<String>(videoId);
        provideDummy<Result<String>>(mockResult);

        when(mockGetVideoUsecase.convetIdToVideo(videoUrl: videoUrl))
            .thenAnswer((_) async => mockResult);

        return detailsFoodCubit;
      },
      act: (bloc) => bloc.doIntent(GetYoutubeIdEvent(videoUrl: videoUrl)),
      expect: () => [
        const DetailsFoodState(
          detailsFoodState: StateStatus<String>.success(videoId),
        ),
      ],
      verify: (_) {
        verify(mockGetVideoUsecase.convetIdToVideo(videoUrl: videoUrl))
            .called(1);
      },
    );

    blocTest<DetailsFoodCubit, DetailsFoodState>(
      "should emit failure state when FailedResult back",
      build: () {
        final mockResult = FailedResult<String>("error");
        provideDummy<Result<String>>(mockResult);

        when(mockGetVideoUsecase.convetIdToVideo(videoUrl: videoUrl))
            .thenAnswer((_) async => mockResult);

        return detailsFoodCubit;
      },
      act: (bloc) => bloc.doIntent(GetYoutubeIdEvent(videoUrl: videoUrl)),
      expect: () => [
        const DetailsFoodState(
          detailsFoodState: StateStatus<String>.failure(
            ResponseException(message: "error"),
          ),
        ),
      ],
    );
  });

  // -------------------------------------------------------------------
  group("test _getMeal fn", () {
    const mealId = "123";
    const mealResponse = MealResponseEntity(meal:  []);

    blocTest<DetailsFoodCubit, DetailsFoodState>(
      "should emit loading then success when SuccessResult back",
      build: () {
        final mockResult = SuccessResult<MealResponseEntity>(mealResponse);
        provideDummy<Result<MealResponseEntity>>(mockResult);

        when(mockGetMealDetailsUsecase.getMealDetails(mealId: mealId))
            .thenAnswer((_) async => mockResult);

        return detailsFoodCubit;
      },
      act: (bloc) => bloc.doIntent(GetMealDetailsEvent(mealId: mealId)),
      expect: () => [
        const DetailsFoodState(
          detailsFoodState: StateStatus<MealResponseEntity>.loading(),
        ),
        const DetailsFoodState(
          detailsFoodState: StateStatus<MealResponseEntity>.success(mealResponse),
        ),
      ],
      verify: (_) {
        verify(mockGetMealDetailsUsecase.getMealDetails(mealId: mealId))
            .called(1);
      },
    );

    blocTest<DetailsFoodCubit, DetailsFoodState>(
      "should emit loading then failure when FailedResult back",
      build: () {
        final mockResult = FailedResult<MealResponseEntity>("error");
        provideDummy<Result<MealResponseEntity>>(mockResult);

        when(mockGetMealDetailsUsecase.getMealDetails(mealId: mealId))
            .thenAnswer((_) async => mockResult);

        return detailsFoodCubit;
      },
      act: (bloc) => bloc.doIntent(GetMealDetailsEvent(mealId: mealId)),
      expect: () => [
        const DetailsFoodState(
          detailsFoodState: StateStatus<MealResponseEntity>.loading(),
        ),
        const DetailsFoodState(
          detailsFoodState: StateStatus<MealResponseEntity>.failure(
            ResponseException(message: "error"),
          ),
        ),
      ],
    );
  });
}
