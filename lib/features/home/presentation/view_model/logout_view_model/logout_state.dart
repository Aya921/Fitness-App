import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';

class LogoutState extends Equatable {
  final StateStatus<void>? logoutStatus;

  const LogoutState({
    this.logoutStatus=const StateStatus.loading(),
  });

  LogoutState copyWith({final StateStatus<void>? logoutStatus}) {
    return LogoutState(logoutStatus: logoutStatus ?? this.logoutStatus);
  }

  @override
  List<Object?> get props => [logoutStatus];
}
