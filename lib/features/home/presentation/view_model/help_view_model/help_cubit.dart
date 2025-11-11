import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_intents.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/json_content_use_case/json_content_use_case.dart';

@injectable
class HelpCubit extends Cubit<HelpState> {
  final JsonContentUseCase _jsonContentUseCase;

  HelpCubit(this._jsonContentUseCase) : super(const HelpState());

  Future<void> doIntent(HelpIntents intent) async {
    switch (intent) {
      case LoadHelpContentIntent():
        await _loadHelpContent();
        break;
    }
  }
  Future<void> _loadHelpContent() async {
    emit(state.copyWith(
      helpContentState: const StateStatus.loading(),
    ));

    final result = await _jsonContentUseCase.callHelp();

    switch (result) {
      case SuccessResult<HelpContentEntity>():
        emit(state.copyWith(
          helpContentState: StateStatus.success(result.successResult),
        ));
        break;
      case FailedResult<HelpContentEntity>():
        emit(state.copyWith(
          helpContentState: StateStatus.failure(
            ResponseException(message: result.errorMessage),
          ),
        ));
        break;
    }
  }
}