import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/domain/repo/edit_profile/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepo _editProfileRepo;
  EditProfileUseCase(this._editProfileRepo);

  Future<Result<AuthEntity>> call(EditProfileRequest request) {
    return _editProfileRepo.editProfile(request);
  }
}
