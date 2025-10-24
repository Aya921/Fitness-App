import 'package:dio/dio.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
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
  factory AuthApiServices(Dio dio) = _AuthApiServices;

  @POST(EndPointsConstants.forgetPassEndPoint)
  Future<ForgetPassResponseModel> forgetPassword(
    @Body() ForgetPassRequestModel body,
  );
  @POST(EndPointsConstants.verifyResetCode)
  Future<SendCodeResponseModel> sendCode(
    @Body() SendCodeRequestModel body,
  );
  @PUT(EndPointsConstants.resetPass)
  Future<ResetPassResponseModel> resetPass(
    @Body() ResetPassRequestModel body,
  );
}
