import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/repository/details_food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVideoUsecase {
  final DetailsFoodRepo _detailsFoodRepo;
  GetVideoUsecase(this._detailsFoodRepo);

  Future<Result<String>> convetIdToVideo ({required String videoUrl}) async {
    return await _detailsFoodRepo.convertIdToVideo(videoUrl);
  }
}
