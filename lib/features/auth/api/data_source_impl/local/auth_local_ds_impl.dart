import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/features/auth/data/data_source/local/auth_local_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:AuthLocalDs )
class AuthLocalDsImpl implements AuthLocalDs {
  final AuthApiServices _authApiServices;
  AuthLocalDsImpl(this._authApiServices);
}
