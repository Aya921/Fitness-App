import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';

class DetailsFoodState extends Equatable {
  final StateStatus<void> detailsFoodState;

  const DetailsFoodState({
    this.detailsFoodState = const StateStatus.initial(),
  });

  DetailsFoodState copyWith({StateStatus<void>? status}) {
    return DetailsFoodState(
      detailsFoodState: status ?? detailsFoodState,
    );
  }

  @override
  List<Object?> get props => [detailsFoodState];
}
