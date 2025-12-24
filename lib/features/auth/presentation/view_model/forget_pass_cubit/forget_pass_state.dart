import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';

class ForgetPasswordState extends Equatable {
  final StateStatus<void> forgetPasswordState;

  const ForgetPasswordState({
    this.forgetPasswordState = const StateStatus.initial(),
  });

  ForgetPasswordState copyWith({StateStatus<void>? status}) {
    return ForgetPasswordState(
      forgetPasswordState: status ?? forgetPasswordState,
    );
  }

  @override
  List<Object?> get props => [forgetPasswordState];
}
