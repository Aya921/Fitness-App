import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:fitness/features/home/api/models/exercises/all_exercises_response.dart';
import 'package:fitness/features/home/api/models/exercises/difficulty_by_prime_mover_muscles_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(EndPointsConstants.difficultyByPrimeMoverMuscle)
  Future<DifficultyByPrimeMoverMusclesResponse>
  getDifficultyLevelsByPrimeMoverMuscles({
    @Query(EndPointsConstants.primeMoverMuscleId) required String primeMoverMuscleId,
  });

  @GET(EndPointsConstants.exercisesByMuscleAndDifficulty)
  Future<AllExercisesResponse> getExercisesByMuscleAndDifficulty({
    @Query(EndPointsConstants.primeMoverMuscleId) required String primeMoverMuscleId,
    @Query(EndPointsConstants.difficultyLevelId) required String difficultyLevelId,
    @Query(EndPointsConstants.page) int page = 1,
    @Query(EndPointsConstants.limit) int limit = 10,
  });
}
