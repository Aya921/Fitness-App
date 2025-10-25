import 'dart:async';
import 'package:fitness/core/enum/levels.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../domain/use_case/register_use_case.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const RegisterState());
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
late AutovalidateMode autoValidateMode;
  late GlobalKey<FormState> registerFormKey;

  Future<void> doIntent({required RegisterIntent intent}) async {
    switch (intent) {
      case RegisterInitializationIntent():
        _onInit();
        break;
      case ChangeGenderIntent():
        _changeGender(gender: intent.selectedGender);
        break;
      case RegisterFormIntent():
        await _register();
        break;
      case ToggleObscurePasswordIntent():
        _togglePasswordObscure();
        break;

      case SelectHeightIntent():
        _chooseHeight(heigh: intent.height!);
      case SelectWeightIntent():
        _chooseWeight(weight: intent.weight!);
      case SelectAgeIntent():
        _chhoseAge(age: intent.age!);
      case SelectGoalIntent():
        _chooseGoal(goal: intent.goal!);
      case SelectLevelIntent():
        _chooseLevel(level: intent.level!);
      case ValidateBasicInfoIntent():
      _validateBasicInfo();
        break;
      case IsTypingIntent():
      _isTyping();
        break;
    }
  }

  void _chooseLevel({required ActivityLevel level}) {
    emit(state.copyWith(level: level));
  }

  void _chooseGoal({required String goal}) {
    emit(state.copyWith(goal: goal));
  }

  void _chooseHeight({required int heigh}) {
    emit(state.copyWith(height: heigh));
  }

  void _chhoseAge({required int age}) {
    emit(state.copyWith(age: age));
  }

  void _chooseWeight({required int weight}) {
    emit(state.copyWith(weight: weight));
  }

  void _onInit() {
    registerFormKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    autoValidateMode = AutovalidateMode.disabled;
    emit(state.copyWith(autoValidateMode: AutovalidateMode.disabled));
  }

  void _enableAutoValidateMode() {
    emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
  }

  void _togglePasswordObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _toggleConfirmPasswordObscure() {
    emit(state.copyWith(isObscureConfirm: !state.isObscureConfirm));
  }

void _validateBasicInfo() {
  if (registerFormKey.currentState!.validate()) {
      emit(state.copyWith(isBasicInfoValid: true));
    return;
  }else{
 _enableAutoValidateMode();
  emit(state.copyWith(isBasicInfoValid: false));
  }
  
}
  Future<void> _register() async {
   emit(state.copyWith(registerStatus: const StateStatus.loading()));
    final request = RegisterRequest(
      userInfo: UserInfo(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        rePassword: passwordController.text.trim(),
        gender: state.selectedGender?.toLowerCase(),
      ),
      userBodyInfo: UserBodyInfo(
        height: state.height,
        weight: state.weight,
        age: state.age,
        goal: state.goal,
        activityLevel: state.level?.name,
      ),
    );
    emit(state.copyWith(registerStatus: const StateStatus.loading()));

    final result = await _registerUseCase.register(request);

    switch (result) {
      case SuccessResult<UserEntity>():
        emit(state.copyWith(registerStatus:  StateStatus.success(result.successResult)));
        break;
      case FailedResult<UserEntity>():
          emit(
            state.copyWith(
              registerStatus: StateStatus.failure(
                ResponseException(message: result.errorMessage),
              ),
            ),
          );
        break;
    }
  }

  void _changeGender({required String? gender}) {
    emit(state.copyWith(selectedGender: gender));
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
  
  void _isTyping() {
    final isFilled =firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty&&
    emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
   emit(state.copyWith(isTyping: isFilled));
  }
}
