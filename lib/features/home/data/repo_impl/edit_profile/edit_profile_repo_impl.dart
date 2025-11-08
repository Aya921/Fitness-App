import 'dart:io';

import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/data/data_source/edit_profile/edit_profile_ds.dart';
import 'package:fitness/features/home/domain/repo/edit_profile/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo{
 final EditProfileDs _editProfileDs;
  const EditProfileRepoImpl(this._editProfileDs);

  @override
  Future<Result<AuthEntity>> editProfile(EditProfileRequest request){
    return _editProfileDs.editProfile(request);
  }

  @override
  Future<Result<String>> uploadUserPhoto(File photo) {
   return _editProfileDs.uploadUserPhoto(photo);
  }
}