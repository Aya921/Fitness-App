part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final StateStatus<AuthEntity>? editProfileStatus;
  final bool hasChanges;
  final int? selectedWeight;
  final String? updatedGoal;
  final ActivityLevel? updatedLevel;
  final StateStatus<String>? uploadPhotoStatus;
  final File? selectedPhoto;

  const EditProfileState({
    this.editProfileStatus = const StateStatus.initial(),
    this.hasChanges = false,
    this.selectedWeight,
    this.updatedGoal,
    this.updatedLevel,
    this.uploadPhotoStatus,
    this.selectedPhoto
  });

  EditProfileState copyWith({
    StateStatus<AuthEntity>? editProfileStatus,
    final bool? hasChanges,
    final int? selectedWeight,
    final String? updatedGoal,
    final ActivityLevel? updatedLevel,
    final StateStatus<String>? uploadPhotoStatus,
    File? selectedPhoto
  }) {
    return EditProfileState(
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      hasChanges: hasChanges ?? this.hasChanges,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      updatedGoal: updatedGoal ?? this.updatedGoal,
      updatedLevel: updatedLevel ?? this.updatedLevel,
      uploadPhotoStatus: uploadPhotoStatus ?? this.uploadPhotoStatus,
      selectedPhoto: selectedPhoto??this.selectedPhoto
    );
  }

  @override
  List<Object?> get props => [
    editProfileStatus,
    hasChanges,
    selectedWeight,
    updatedGoal,
    updatedLevel,
    selectedPhoto
  ];
}
