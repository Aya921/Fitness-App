import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/domain/usecase/get_meal_details_usecase.dart';
import 'package:fitness/features/meal_details/domain/usecase/get_video_usecase.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_event.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsFoodCubit extends Cubit<DetailsFoodState> {
  final GetVideoUsecase _getVideoUsecase;
  final GetMealDetailsUsecase _getMealDetailsUsecase;

  DetailsFoodCubit(this._getVideoUsecase, this._getMealDetailsUsecase)
    : super(const DetailsFoodState());

  Future<void> doIntent(DetailsFoodEvent intent) async {
    switch (intent) {
      case GetYoutubeIdEvent():
        _getVideo(intent.videoUrl);
      case GetMealDetailsEvent():
        _getMeal(intent.mealId);
    }
  }

  Future<void> _getVideo(String videoUrl) async {
    final res = await _getVideoUsecase.convetIdToVideo(videoUrl: videoUrl);
    switch (res) {
      case SuccessResult<String>():
        emit(
          state.copyWith(
            status: StateStatus<String>.success(res.successResult),
          ),
        );
      case FailedResult<String>():
        emit(
          state.copyWith(
            status: StateStatus<String>.failure(
              ResponseException(message: res.errorMessage),
            ),
          ),
        );
    }
  }

  Future<void> _getMeal(String mealId) async {
    emit(
      state.copyWith(status: const StateStatus<MealResponseEntity>.loading()),
    );
    final res = await _getMealDetailsUsecase.getMealDetails(mealId: mealId);
    switch (res) {
      case SuccessResult<MealResponseEntity>():
        emit(
          state.copyWith(
            status: StateStatus<MealResponseEntity>.success(res.successResult),
          ),
        );
      case FailedResult<MealResponseEntity>():
        emit(
          state.copyWith(
            status: StateStatus<MealResponseEntity>.failure(
              ResponseException(message: res.errorMessage),
            ),
          ),
        );
    }
  }
}
