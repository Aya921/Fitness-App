
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/use_case/get_logged_user_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ProfileCubit extends Cubit<ProfileState>{
  final GetLoggedUserUseCase _getLoggedUserUseCase;
   ProfileCubit(this._getLoggedUserUseCase)
    : super(const ProfileState());

  Future<void> doIntent(ProfileIntents intent)async {
    switch(intent) {
      case GetLoggedUserIntent():
       _getLoggedUsetData();
        break;
      case ChangeLanguageSwitch():
      _changeLanguageSwitch();
      break;
    }
  }

  Future<void> _getLoggedUsetData() async {
    emit(state.copyWith(userData: const StateStatus.loading()));
    final response = await _getLoggedUserUseCase.call();
    switch (response) {
      case SuccessResult<AuthEntity>():
        emit(
          state.copyWith(userData: StateStatus.success(response.successResult)),
        );
        break;
      case FailedResult<AuthEntity>():
        emit(
          state.copyWith(
            userData: StateStatus.failure(
              ResponseException(message: response.errorMessage),
            ),
          ),
        );
        break;
    }
  }

   void _changeLanguageSwitch(){
    emit(state.copyWith(switchLanguage: !state.switchLanguage));
   }
}