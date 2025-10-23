import 'dart:async';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
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

   final TextEditingController firstNameController
   =TextEditingController(text: "mariam");
   final TextEditingController lastNameController
  =TextEditingController(text: "mohmed");
   final TextEditingController emailController=
   TextEditingController(text: "mariam0599@gmail.com");
   final TextEditingController passwordController  =
   TextEditingController(text: "Pass123@");
   final TextEditingController confirmPasswordController =
   TextEditingController(text: "Pass123@");

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
        _chooseHeight(
          heigh: intent.height!
        );
      case SelectWeightIntent():
       _chooseWeight(weight: intent.weight!);
      case SelectAgeIntent():
     _chhoseAge(
       age: intent.age!
     );
      case SelectGoalIntent():
      _chooseGoal(goal: intent.goal!);
      case SelectLevelIntent():
     _chooseLevel(level: intent.level!);
    }
  }
  void _chooseLevel({required String level}){
    emit(state.copyWith(
        level: level
    ));
  }
  void _chooseGoal({required String goal}){
  emit(state.copyWith(
    goal: goal
  ));
  }
void _chooseHeight({required int heigh}){

    emit(state.copyWith(height: heigh));

}

  void _chhoseAge({required int age}) {
    emit(state.copyWith(
      age: age
    ));
  }
  void _chooseWeight({required int weight}){

      emit(state.copyWith(weight: weight));

  }
  void _onInit() {
    registerFormKey = GlobalKey<FormState>();
    // firstNameController = TextEditingController();
    // lastNameController = TextEditingController();
    // emailController = TextEditingController();
    // passwordController = TextEditingController();
    // confirmPasswordController = TextEditingController();

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

  Future<void> _register() async {

    emit(state.copyWith(registerStatus: const StateStatus.loading()));
    final request = RegisterRequest(
      userInfo: UserInfo(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        rePassword: confirmPasswordController.text.trim(),
        gender: state.selectedGender,

      ),
      userBodyInfo: UserBodyInfo(
        height: state.height,
        weight: state.weight,
        age: state.age,
        goal: state.goal,
        activityLevel: state.level,
      ),
    );
    emit(state.copyWith(registerStatus: const StateStatus.loading()));

    final result = await _registerUseCase.register( request);

    switch (result) {
      case SuccessResult<void>():
        emit(state.copyWith(
          registerStatus: const StateStatus.success(null),
        ));
        break;
      case FailedResult<void>():
        final error = (result as FailedResult).errorMessage;
        if (error is ResponseException) {
          emit(state.copyWith(
            error: error,
            registerStatus: StateStatus.failure(error as ResponseException),
          ));
        } else {
          emit(state.copyWith(
            error: error,
            registerStatus: StateStatus.failure(
              ResponseException(message: error.toString()),
            ),
          ));
        }
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
    confirmPasswordController.dispose();
    return super.close();
  }


}