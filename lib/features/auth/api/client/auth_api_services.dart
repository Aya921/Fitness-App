import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl+EndPointsConstants.authEndPoint)
@injectable
abstract class AuthApiServices {
  @factoryMethod
  factory AuthApiServices(Dio dio) = _AuthApiServices;
}
