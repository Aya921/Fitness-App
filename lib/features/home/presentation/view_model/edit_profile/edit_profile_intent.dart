import 'package:fitness/core/enum/levels.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';

sealed class EditProfileIntent {}

class EditBtnSubmittedIntent implements EditProfileIntent {
  EditProfileRequest request;
  EditBtnSubmittedIntent({required this.request});
}

class InitializeControllers implements EditProfileIntent {
  UserEntity? user;
  InitializeControllers(this.user);
}

class WeightChangedIntent implements EditProfileIntent {
  final int weight;
  WeightChangedIntent(this.weight);
}

class GoalChangedIntent implements EditProfileIntent {
  final String goal;
  GoalChangedIntent(this.goal);
}

class LevelChangedIntent implements EditProfileIntent {
  final ActivityLevel level;
  LevelChangedIntent(this.level);
}

class PickPhotoIntent implements EditProfileIntent {}

