import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/forget_pass_request_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/forget_pass_response_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/reset_pass_request_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/reset_pass_response_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/send_code_request_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/send_code_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';


part 'auth_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl + EndPointsConstants.authEndPoint)
@injectable
abstract class AuthApiServices {
  @factoryMethod
  factory AuthApiServices(Dio dio  ) = _AuthApiServices;
  @POST(EndPointsConstants.signUpEndPoint)
  Future<AuthResponse>register(@Body()RegisterRequest request);

  @POST(EndPointsConstants.signIn)
  Future<AuthResponse> logIn(@Body() Map<String, dynamic> body);

  @GET(EndPointsConstants.getLoggedUser)
  Future<AuthResponse> getLoggedUser();

  @POST(EndPointsConstants.forgetPassEndPoint)
  Future<ForgetPassResponseModel> forgetPassword(
    @Body() ForgetPassRequestModel body,
  );
  @POST(EndPointsConstants.verifyResetCode)
  Future<SendCodeResponseModel> sendCode(@Body() SendCodeRequestModel body);

  @PUT(EndPointsConstants.resetPass)
  Future<ResetPassResponseModel> resetPass(@Body() ResetPassRequestModel body);
}
