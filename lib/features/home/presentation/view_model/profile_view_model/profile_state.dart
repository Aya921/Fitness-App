import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';

class ProfileState extends Equatable {
  final StateStatus<List<dynamic>> dataState;
  // final StateStatus<List<dynamic>> securityState;
  // final StateStatus<List<dynamic>> privacyPolicyState;
  final StateStatus<AuthEntity> userData;
  final bool switchValue;

  const ProfileState({
    this.dataState =const StateStatus.initial(),
    this.switchValue = true,
    //  this.securityState =const StateStatus.initial(),
    //  this.privacyPolicyState =const StateStatus.initial(),
     this.userData =const StateStatus.initial(),
  });

  ProfileState copyWith({
    final StateStatus<List<dynamic>>? dataState,
    // final StateStatus<List<dynamic>>? securityState,
    // final StateStatus<List<dynamic>>? privacyPolicyState,
    final StateStatus<AuthEntity>? userData,
    final bool? switchValue,
  }) {
    return ProfileState(
      dataState: dataState ?? this.dataState,
      // securityState: securityState ?? this.securityState,
      // privacyPolicyState: privacyPolicyState ?? this.privacyPolicyState,
      userData: userData ?? this.userData,
      switchValue: switchValue ?? this.switchValue,
    );
  }

  @override
  List<Object?> get props => [
    dataState,
    // helpState,
    // securityState,
    // privacyPolicyState,
    userData,
    switchValue,
  ];
}
