import 'package:fitness/features/home/domain/entity/workout/equipment_entity.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_video_entity.dart';
import 'package:fitness/features/home/domain/entity/workout/motion_entity.dart';
import 'package:fitness/features/home/domain/entity/workout/muscle_entity.dart';

class ExerciseEntity {
  final String? id;
  final String? name;
  final String? difficultyLevel;
  final String? bodyRegion;

  final MuscleEntity? muscle;
  final EquipmentEntity? equipment;
  final MotionEntity? motion;
  final ExerciseVideoEntity? video;

  ExerciseEntity({
    this.id,
    this.name,
    this.difficultyLevel,
    this.bodyRegion,
    this.muscle,
    this.equipment,
    this.motion,
    this.video,
  });
}
