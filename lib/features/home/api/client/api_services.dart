import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscle_group_by_id/muscle_group_id_response.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscles_group_response/muscles_group_response.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscles_random_response/muscles_random_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(EndPointsConstants.musclesRandom)
  Future<MusclesRandomResponse> getAllRandomMuscles();

   @GET(EndPointsConstants.allMusclesGroups)
  Future<MusclesGroupResponse> getAllMusclesGroup();

  @GET(EndPointsConstants.musclesGroupById)
  Future<MuscleGroupIdResponse> getAllMusclesGroupById(
    @Path("id")String? id);
}