import 'package:fitness/core/result/result.dart';

import 'package:fitness/features/home/data/details_food_data_source/details_food_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@Injectable(as: DetailsFoodDataSource)
class DetailsFoodDataSouceImp implements DetailsFoodDataSource {
  DetailsFoodDataSouceImp();

  @override
  Future<Result<String>> convertIdToVideo(String videoUrl) async {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    try {
      return SuccessResult(videoId);
    } catch (e) {
      return FailedResult(e.toString());
    }
  }
}
