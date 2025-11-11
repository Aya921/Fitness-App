import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';

class SecurityState extends Equatable {
  final StateStatus<SecurityRolesEntity> securityRolesState;

  const SecurityState({
    this.securityRolesState = const StateStatus.initial(),
  });

  SecurityState copyWith({
    StateStatus<SecurityRolesEntity>? securityRolesState,
  }) {
    return SecurityState(
      securityRolesState: securityRolesState ?? this.securityRolesState,
    );
  }

  @override
  List<Object?> get props => [securityRolesState];
}