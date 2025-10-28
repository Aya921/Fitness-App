import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/details_food_data_source/details_food_data_source.dart';
import 'package:fitness/features/home/domain/repository/details_food_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DetailsFoodRepo)
class DetailsFoodRepoImp implements DetailsFoodRepo {
  final DetailsFoodDataSource _detailsFoodDataSource;

  DetailsFoodRepoImp(this._detailsFoodDataSource);

  @override
  Future<Result<String>> convertIdToVideo(String videoUrl) async {
    return await _detailsFoodDataSource.convertIdToVideo(videoUrl);
  }
}
