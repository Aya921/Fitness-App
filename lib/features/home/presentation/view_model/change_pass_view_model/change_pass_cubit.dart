import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/chage_pass/change_pass_request.dart';
import 'package:fitness/features/home/domain/usecase/change_pass_usecase/change_pass_usecase.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_event.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePassCubit extends Cubit<ChangePassState> {
  final ChangePassUsecase _changePassUsecase;


  ChangePassCubit(
   
    this._changePassUsecase,
  ) : super(const ChangePassState());

  Future<void> doIntent(ChangePassEvent intent) async {
    switch (intent) {
     
      case SendPassAndNewPassEvent():
        _changePass(intent.changePassRequest);
}  }

  Future<void> _changePass(ChangePassRequest request) async {
    emit(
      state.copyWith(status: const StateStatus<void>.loading()),
    );
    final res = await _changePassUsecase.changePass(req: request);


    switch (res) {
      case SuccessResult<void>():
        emit(
          state.copyWith(
            status: StateStatus<void>.success(res.successResult),
          ),
        );
      case FailedResult<void>():
        emit(state.copyWith(status: StateStatus<void>.failure(ResponseException(message: res.errorMessage))));
    }
  }


}
