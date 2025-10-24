import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl + EndPointsConstants.authEndPoint)
@injectable
abstract class AuthApiServices {
  @factoryMethod
  factory AuthApiServices(Dio dio) = _AuthApiServices;

  @POST(EndPointsConstants.signIn)
  Future<AuthResponse> logIn(@Body() Map<String, dynamic> body);

  @GET(EndPointsConstants.getLoggedUser)
  Future<AuthResponse> getLoggedUser();
}
