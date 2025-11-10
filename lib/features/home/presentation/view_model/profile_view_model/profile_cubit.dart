import 'dart:convert';

import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/constants/json_files.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/use_case/get_logged_user_use_case.dart';
import 'package:fitness/features/home/domain/use_case/json_content_use_case/json_content_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ProfileCubit extends Cubit<ProfileState>{
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  final JsonContentUseCase _jsonContentUseCase;
   ProfileCubit(this._getLoggedUserUseCase,this._jsonContentUseCase)
    : super(const ProfileState());

  Future<void> doIntent(ProfileIntents intent)async {
    switch(intent) {
      case HelpIntent():
        await _loadJsonScreen(JsonFiles.help);
       break;
      case SecurityIntent():
         await _loadJsonScreen(JsonFiles.security);
       break;
      case PrivacyPolicyIntent():
         await _loadJsonScreen(JsonFiles.privacyPolicy);
       break;
      case GetLoggedUserIntent():
       _getLoggedUsetData();
        break;
      case ChangeLanguageSwitch():
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

  Future<void> _loadJsonScreen(String assetPath) async {
    try {
      emit(
        state.copyWith(dataState: const StateStatus.loading()),
      );
      final List<dynamic> jsonContent = await _jsonContentUseCase.invok(assetPath);
      if (isClosed) return;
     
      emit(
        state.copyWith(
          dataState: StateStatus.success(
            jsonContent,
          ),
        ),
      );
    } catch (error) {
       if (isClosed) return;
      emit(
        state.copyWith(
          dataState: StateStatus.failure(
            ResponseException(
              message: "${Constants.anUnknownErrorOccurred} ${error.toString()}",
            ),
          ),
        ),
      );
    }
  }
}