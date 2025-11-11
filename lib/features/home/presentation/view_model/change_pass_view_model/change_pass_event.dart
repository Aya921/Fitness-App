import 'package:fitness/features/home/domain/entities/chage_pass/change_pass_request.dart';

sealed class ChangePassEvent {}

final class SendPassAndNewPassEvent extends ChangePassEvent {
  final ChangePassRequest changePassRequest;
  SendPassAndNewPassEvent({required this.changePassRequest});
}

