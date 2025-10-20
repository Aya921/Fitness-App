import 'package:equatable/equatable.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';

class UserEntity extends Equatable {
  final PersonalInfoEntity? personalInfo;
  final BodyInfoEntity? bodyInfo;
  final String? activityLevel;
  final String? goal;

  const UserEntity({
    this.personalInfo,
    this.bodyInfo,
    this.activityLevel,
    this.goal,
  });

  @override
  List<Object?> get props => [
    personalInfo,
    bodyInfo,
    activityLevel,
    goal
  ];
}
