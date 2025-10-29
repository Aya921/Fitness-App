import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:fitness/features/home/api/models/workout/all_difficulty_levels_response.dart';
import 'package:fitness/features/home/api/models/workout/all_exercises_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(EndPointsConstants.allExercises)
  Future<AllExercisesResponse> getAllExercises({
    @Query("page") int page = 1,
    @Query("limit") int limit = 5980,
  });

  @GET(EndPointsConstants.difficultyLevels)
  Future<AllDifficultyLevelsResponse> getDifficultyLevels();
}
