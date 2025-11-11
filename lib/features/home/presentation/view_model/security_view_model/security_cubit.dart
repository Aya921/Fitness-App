import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_intent.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/json_content_use_case/json_content_use_case.dart';

@injectable
class SecurityCubit extends Cubit<SecurityState> {
  final JsonContentUseCase _jsonContentUseCase;

  SecurityCubit(this._jsonContentUseCase) : super(const SecurityState());


Future<void>doIntent(SecurityIntents intent) async {
    switch (intent) {
      case LoadSecurityPolicyIntent():
        await _loadSecurityRoles();
        break;
    }
  }

  Future<void> _loadSecurityRoles() async {
    emit(state.copyWith(
      securityRolesState: const StateStatus.loading(),
    ));

    final result = await _jsonContentUseCase.callSecurity();

    switch (result) {
      case SuccessResult<SecurityRolesEntity>():
        emit(state.copyWith(
          securityRolesState: StateStatus.success(result.successResult),
        ));
        break;
      case FailedResult<SecurityRolesEntity>():
        emit(state.copyWith(
          securityRolesState: StateStatus.failure(
            ResponseException(message: result.errorMessage),
          ),
        ));
        break;
    }
  }
}