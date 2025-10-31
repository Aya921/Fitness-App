import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';

import 'package:fitness/features/meal_details/data/details_food_data_source/details_food_data_source.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/remote/details_food_api/client/details_food_api_service.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@Injectable(as: DetailsFoodDataSource)
class DetailsFoodDataSourceImp implements DetailsFoodDataSource {
  final DetailsFoodApiService _detailsFoodApiService;
  const DetailsFoodDataSourceImp(this._detailsFoodApiService);

  @override
  Future<Result<String>> convertIdToVideo(String videoUrl) async {
    try {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId == null) {
      return FailedResult(Constants.invalidUrl);
    }
    return SuccessResult(videoId);
    } catch (e) {
      return FailedResult(e.toString());
    }
  }

  @override
  Future<Result<MealResponseEntity>> getMealDetails({
    required String mealId,
  }) async {
    return safeApiCall(() async {
      final mealResponse = await _detailsFoodApiService.getMealDetails(mealId);
      return (mealResponse.toEntity());
    });
  }
}
