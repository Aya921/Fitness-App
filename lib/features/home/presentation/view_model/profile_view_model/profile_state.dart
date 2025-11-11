import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';

class ProfileState extends Equatable {
  final StateStatus<List<dynamic>> dataState;
  final bool switchLanguage;
  final StateStatus<AuthEntity> userData;
  final StateStatus<void>? logoutStatus;

  const ProfileState({
    this.dataState =const StateStatus.initial(),
    this.switchLanguage = true,
       this.userData =const StateStatus.initial(),
    this.logoutStatus=const StateStatus.loading(),
  });

  ProfileState copyWith({
    final StateStatus<List<dynamic>>? dataState,
    final StateStatus<AuthEntity>? userData,
    final bool? switchLanguage,
  final StateStatus<void>? logoutStatus
  }) {
    return ProfileState(
      dataState: dataState ?? this.dataState,
      userData: userData ?? this.userData,
      switchLanguage: switchLanguage ?? this.switchLanguage,
        logoutStatus: logoutStatus ?? this.logoutStatus
    );
  }

  @override
  List<Object?> get props => [
    dataState,
    userData,
    switchLanguage,
    logoutStatus
  ];
}
