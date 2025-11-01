import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entity/exercises/equipment_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_video_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/motion_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/muscle_entity.dart';

class ExerciseEntity extends Equatable {
  final String? id;
  final String? name;
  final String? difficultyLevel;
  final String? bodyRegion;

  final MuscleEntity? muscle;
  final EquipmentEntity? equipment;
  final MotionEntity? motion;
  final ExerciseVideoEntity? video;

  const ExerciseEntity({
    this.id,
    this.name,
    this.difficultyLevel,
    this.bodyRegion,
    this.muscle,
    this.equipment,
    this.motion,
    this.video,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    difficultyLevel,
    bodyRegion,
    muscle,
    equipment,
    motion,
    video,
  ];
}
