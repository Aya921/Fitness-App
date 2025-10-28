import 'package:fitness/core/result/result.dart';

abstract interface class DetailsFoodRepo {
  Future<Result<String>> convertIdToVideo(String videoUrl);
}
