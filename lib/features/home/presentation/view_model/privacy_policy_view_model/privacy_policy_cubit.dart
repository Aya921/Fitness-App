import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/use_case/json_content_use_case/json_content_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_intent.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final JsonContentUseCase _jsonContentUseCase;

  PrivacyPolicyCubit(this._jsonContentUseCase)
      : super(const PrivacyPolicyState());
  
  Future<void> doIntent(PrivacyPolicyIntent intent) async {
    switch (intent) {
      case LoadPrivacyPolicyIntent():
        await _loadPrivacyPolicy();
        break;
    }
  }
  Future<void> _loadPrivacyPolicy() async {
    emit(state.copyWith(
      privacyPolicyState: const StateStatus.loading(),
    ));

    final result = await _jsonContentUseCase.callPrivacy();

    switch (result) {
      case SuccessResult<PrivacyPolicyEntity>():
        emit(state.copyWith(
          privacyPolicyState: StateStatus.success(result.successResult),
        ));
        break;
      case FailedResult<PrivacyPolicyEntity>():
        emit(state.copyWith(
          privacyPolicyState: StateStatus.failure(
            ResponseException(message: result.errorMessage),
          ),
        ));
        break;
    }
  }
}