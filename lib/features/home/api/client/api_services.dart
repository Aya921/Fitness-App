import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:fitness/features/home/api/models/change_pass/change_pass_request_model.dart';
import 'package:fitness/features/home/api/models/change_pass/change_pass_response.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
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

  @PATCH(EndPointsConstants.changePassword)
  Future<ChangePassResponse> changePassword({
    @Body() required ChangePassRequestModel changePasswordRequest,
  });

  @PUT(EndPointsConstants.editProfile)
  Future<AuthResponse> editProfile(@Body() EditProfileRequest request);

  @PUT(EndPointsConstants.uploadPhoto)
  @MultiPart()
  Future<String> uploadUserPhoto(@Part(name:EndPointsConstants.photo) File photo,);
}
