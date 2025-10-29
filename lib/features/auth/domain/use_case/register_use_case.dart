import 'package:injectable/injectable.dart';
import '../../../../core/result/result.dart';
import '../../api/models/register/request/register_request.dart';
import '../entity/auth/user_entity.dart';
import '../repository/auth_repo.dart';
@injectable
class RegisterUseCase{
  final AuthRepo _authRepo;
  const RegisterUseCase(this._authRepo);
  Future<Result<UserEntity>> register(RegisterRequest request)async{
    return await _authRepo.register(request);
  }
}