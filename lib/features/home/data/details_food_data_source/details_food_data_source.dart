import 'package:fitness/core/result/result.dart';



abstract interface class DetailsFoodDataSource {
  Future<Result<String>> convertIdToVideo(String videoUrl);
}