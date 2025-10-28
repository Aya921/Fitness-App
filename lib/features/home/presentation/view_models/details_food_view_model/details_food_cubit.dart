import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/usecase/get_video_usecase.dart';
import 'package:fitness/features/home/presentation/view_models/details_food_view_model/details_food_event.dart';
import 'package:fitness/features/home/presentation/view_models/details_food_view_model/details_food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsFoodCubit extends Cubit<DetailsFoodState> {
  final GetVideoUsecase _getVideoUsecase;

  DetailsFoodCubit(this._getVideoUsecase) : super(const DetailsFoodState());

  Future<void> doIntent(DetailsFoodEvent intent) async {
    switch (intent) {
      case GetYoutubeIdEvnet():
        _getVideo(intent.videoUrl);
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
}
