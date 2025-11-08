import 'dart:io';

import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/data/data_source/edit_profile/edit_profile_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileDs)
class EditProfileDsImpl implements EditProfileDs {
  final ApiServices _apiServices;
  const EditProfileDsImpl(this._apiServices);

  @override
  Future<Result<AuthEntity>> editProfile(EditProfileRequest request) {
    return safeApiCall(() async {
      final AuthResponse response = await _apiServices.editProfile(request);
      return response.toEntity();
    });
  }

  @override
  Future<Result<String>> uploadUserPhoto(File photo) {
    return safeApiCall(() => _apiServices.uploadUserPhoto(photo));
  }
}
