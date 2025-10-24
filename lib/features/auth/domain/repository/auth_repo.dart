import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';

abstract interface class AuthRepo {
  Future<Result<ForgetPassResponse>> forgetPass({required 
    ForgetPassRequest forgetPassReq,
  });
  Future<Result<void>> sendCode({required 
    SendCodeRequest code,
  });
  Future<Result<void>> resetPass({required 
    ResetPassRequest resetReq,
  });
}
