import 'dart:io';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/repo/edit_profile/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final EditProfileRepo _editProfileRepo;
  const UploadPhotoUseCase(this._editProfileRepo);

  Future<Result<String>> call(File photo){
    return _editProfileRepo.uploadUserPhoto(photo);
  }
}