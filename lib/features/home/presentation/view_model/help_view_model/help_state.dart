import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';

class HelpState extends Equatable {
  final StateStatus<HelpContentEntity> helpContentState;

  const HelpState({
    this.helpContentState = const StateStatus.initial(),
  });

  HelpState copyWith({
    StateStatus<HelpContentEntity>? helpContentState,
  }) {
    return HelpState(
      helpContentState: helpContentState ?? this.helpContentState,
    );
  }

  @override
  List<Object?> get props => [helpContentState];
}