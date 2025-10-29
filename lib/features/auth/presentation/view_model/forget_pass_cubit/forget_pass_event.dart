import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';

sealed class ForgetPassEvent {}

final class SendForgetPassEmailEvent extends ForgetPassEvent {
  final ForgetPassRequest forgetPassRequest;
  SendForgetPassEmailEvent({required this.forgetPassRequest});
}
final class SendCodeEvent extends ForgetPassEvent {
  final SendCodeRequest sendCodeRequest;
  SendCodeEvent({required this.sendCodeRequest});
}
final class ResetPassEvent extends ForgetPassEvent {
  final ResetPassRequest resetPassRequest;
  ResetPassEvent({required this.resetPassRequest});
}
