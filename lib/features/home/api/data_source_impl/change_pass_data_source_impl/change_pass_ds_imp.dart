import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/api/models/change_pass/change_pass_request_model.dart';
import 'package:fitness/features/home/data/data_source/change_pass_ds/change_pass_ds.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/chage_pass/change_pass_request.dart';

@Injectable(as: ChangePassDs)
class ChangePassDsImp implements ChangePassDs {
  final ApiServices _apiServices;
  final SecureStorageService _secureStorage;
  const ChangePassDsImp(this._apiServices, this._secureStorage);

 @override
Future<Result<void>> changePassword({
  required ChangePassRequest changePassRequest,
}) async {
  return await safeApiCall<void>(() async {
    final response = await _apiServices.changePassword(
      changePasswordRequest: ChangePassRequestModel.toModel(
        changePassRequest,
      ),
    );

 
    if (response.token != null) {
      await _secureStorage.saveToken(response.token!);
    }

    return ; 
  });
}


}
