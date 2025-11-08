import 'dart:io';

import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';

abstract interface class EditProfileDs {
  Future<Result<AuthEntity>> editProfile(EditProfileRequest request);
  Future<Result<String>> uploadUserPhoto(File photo);
}