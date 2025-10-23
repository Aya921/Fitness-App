import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../core/enum/request_state.dart';
class RegisterState extends Equatable {
  final StateStatus<void> registerStatus;
  final bool isObscure;
  final bool isObscureConfirm;
  final AutovalidateMode autoValidateMode;
  final String? selectedGender;
  final String? error;
  final int height;
  final int weight;
final int age;
  final String? goal;
  final String? level;

  const RegisterState({
    this.registerStatus = const StateStatus.initial(),
    this.isObscure = true,
    this.isObscureConfirm = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.selectedGender,
    this.error,
    this.height=160,
    this.weight=60,
    this.age=24,
    this.goal,
    this.level
  });
  RegisterState copyWith({
    StateStatus<void>? registerStatus,
    bool? isObscure,
    bool? isObscureConfirm,
    AutovalidateMode? autoValidateMode,
    String? selectedGender,
     String? error,
    int? height,
    int? weight,
    int? age,
     String? goal,
    String? level


  }) {
    return RegisterState(
age: age??this.age,
      registerStatus: registerStatus ?? this.registerStatus,
      isObscure: isObscure ?? this.isObscure,
      isObscureConfirm: isObscureConfirm ?? this.isObscureConfirm,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      selectedGender: selectedGender ?? this.selectedGender,
      error: error??this.error,
      height: height??this.height,
      weight: weight??this.weight,
      goal: goal??this.goal,
      level: level??this.level
    );
  }

  @override
  List<Object?> get props => [
    registerStatus,
    isObscure,
    isObscureConfirm,
    autoValidateMode,
    selectedGender,
    error,
    height,
    weight,
    age,
    goal,
    level
  ];
}