import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/levels.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/domain/usecase/edit_profile/edit_profile_use_case.dart';
import 'package:fitness/features/home/domain/usecase/edit_profile/upload_photo_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  EditProfileCubit(this._editProfileUseCase, this._uploadPhotoUseCase)
    : super(const EditProfileState());

  late UserEntity? _originalUser;
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> doIntent({required EditProfileIntent intent}) async {
    switch (intent) {
      case InitializeControllers():
        _initializeControllers(intent.user);
        break;
      case EditBtnSubmittedIntent():
        await _editProfile(intent.request);
        break;
      case WeightChangedIntent():
        _onWeightChanged(intent.weight);
        break;
      case GoalChangedIntent():
        _onGoalChanged(intent.goal);
        break;
      case LevelChangedIntent():
        _onLevelChanged(intent.level);
        break;
      case PickPhotoIntent():
        _pickAndUploadPhoto();
        break;
    }
  }

  Future<void> _editProfile(EditProfileRequest request) async {
    emit(state.copyWith(editProfileStatus: const StateStatus.loading()));
    final result = await _editProfileUseCase.call(request);
    switch (result) {
      case SuccessResult<AuthEntity>():
        final updatedUser = result.successResult.user;
        if (updatedUser != null) {
          UserManager().setUser(updatedUser);
          _originalUser = updatedUser;
        }

        emit(
          state.copyWith(
            editProfileStatus: StateStatus.success(result.successResult),
            hasChanges: false,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 300));
        emit(state.copyWith(editProfileStatus: const StateStatus.initial()));

      case FailedResult<AuthEntity>():
        emit(
          state.copyWith(
            editProfileStatus: StateStatus.failure(
              ResponseException(message: result.errorMessage),
            ),
          ),
        );
    }
  }

  void _initializeControllers(UserEntity? user) {
    _originalUser = user;

    firstNameController.text = user?.personalInfo?.firstName ?? '';
    lastNameController.text = user?.personalInfo?.lastName ?? '';
    emailController.text = user?.personalInfo?.email ?? '';

    // Listen to changes
    firstNameController.addListener(_hasChanges);
    lastNameController.addListener(_hasChanges);
    emailController.addListener(_hasChanges);
  }

  //compare last version of user with controllers
  void _hasChanges() {
    final hasChanged =
        firstNameController.text.trim() !=
            (_originalUser?.personalInfo?.firstName ?? '') ||
        lastNameController.text.trim() !=
            (_originalUser?.personalInfo?.lastName ?? '') ||
        emailController.text.trim() !=
            (_originalUser?.personalInfo?.email ?? '');

    if (state.hasChanges != hasChanged) {
      emit(state.copyWith(hasChanges: hasChanged));
    }
  }

  void _onWeightChanged(int weight) {
    emit(state.copyWith(selectedWeight: weight));
  }

  void _onGoalChanged(String updatedGoal) {
    emit(state.copyWith(updatedGoal: updatedGoal));
  }

  void _onLevelChanged(ActivityLevel updatedLevel) {
    emit(state.copyWith(updatedLevel: updatedLevel));
  }

  Future<void> _uploadPhoto(File photo) async {
    emit(state.copyWith(uploadPhotoStatus: const StateStatus.loading()));
    final result = await _uploadPhotoUseCase.call(photo);
    switch (result) {
      case SuccessResult<String>():
        emit(
          state.copyWith(
            uploadPhotoStatus: StateStatus.success(result.successResult),
          ),
        );

      case FailedResult<String>():
        emit(
          state.copyWith(
            editProfileStatus: StateStatus.failure(
              ResponseException(message: result.errorMessage),
            ),
          ),
        );
    }
  }

  Future<void> _pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      emit(state.copyWith(selectedPhoto: file));

      await _uploadPhoto(file);
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
