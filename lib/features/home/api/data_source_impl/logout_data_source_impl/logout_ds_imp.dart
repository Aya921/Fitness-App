import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/data/data_source/logout/logout_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutDs)
class LogoutDsImp implements LogoutDs {
  final ApiServices _apiServices;
  const LogoutDsImp(this._apiServices);

  @override
  Future<Result<void>> logout() {
    return safeApiCall(() async {
       await _apiServices.logout();
    });
  }
}
