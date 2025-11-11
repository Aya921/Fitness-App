import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';

class PrivacyPolicyState extends Equatable {
  final StateStatus<PrivacyPolicyEntity> privacyPolicyState;

  const PrivacyPolicyState({
    this.privacyPolicyState = const StateStatus.initial(),
  });

  PrivacyPolicyState copyWith({
    StateStatus<PrivacyPolicyEntity>? privacyPolicyState,
  }) {
    return PrivacyPolicyState(
      privacyPolicyState: privacyPolicyState ?? this.privacyPolicyState,
    );
  }

  @override
  List<Object?> get props => [privacyPolicyState];
}