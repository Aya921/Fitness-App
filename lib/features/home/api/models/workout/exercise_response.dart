import 'package:fitness/features/home/domain/entity/workout/equipment_entity.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_video_entity.dart';
import 'package:fitness/features/home/domain/entity/workout/motion_entity.dart';
import 'package:fitness/features/home/domain/entity/workout/muscle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_response.g.dart';

@JsonSerializable()
class ExerciseResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "exercise")
  final String? exercise;
  @JsonKey(name: "short_youtube_demonstration")
  final String? shortYoutubeDemonstration;
  @JsonKey(name: "in_depth_youtube_explanation")
  final String? inDepthYoutubeExplanation;
  @JsonKey(name: "difficulty_level")
  final String? difficultyLevel;
  @JsonKey(name: "target_muscle_group")
  final String? targetMuscleGroup;
  @JsonKey(name: "prime_mover_muscle")
  final String? primeMoverMuscle;
  @JsonKey(name: "secondary_muscle")
  final dynamic? secondaryMuscle;
  @JsonKey(name: "tertiary_muscle")
  final dynamic? tertiaryMuscle;
  @JsonKey(name: "primary_equipment")
  final String? primaryEquipment;
  @JsonKey(name: "_primary_items")
  final int? PrimaryItems;
  @JsonKey(name: "secondary_equipment")
  final dynamic? secondaryEquipment;
  @JsonKey(name: "_secondary_items")
  final int? SecondaryItems;
  @JsonKey(name: "posture")
  final String? posture;
  @JsonKey(name: "single_or_double_arm")
  final String? singleOrDoubleArm;
  @JsonKey(name: "continuous_or_alternating_arms")
  final String? continuousOrAlternatingArms;
  @JsonKey(name: "grip")
  final String? grip;
  @JsonKey(name: "load_position_ending")
  final String? loadPositionEnding;
  @JsonKey(name: "continuous_or_alternating_legs")
  final String? continuousOrAlternatingLegs;
  @JsonKey(name: "foot_elevation")
  final String? footElevation;
  @JsonKey(name: "combination_exercises")
  final String? combinationExercises;
  @JsonKey(name: "movement_pattern_1")
  final String? movementPattern1;
  @JsonKey(name: "movement_pattern_2")
  final dynamic? movementPattern2;
  @JsonKey(name: "movement_pattern_3")
  final dynamic? movementPattern3;
  @JsonKey(name: "plane_of_motion_1")
  final String? planeOfMotion1;
  @JsonKey(name: "plane_of_motion_2")
  final dynamic? planeOfMotion2;
  @JsonKey(name: "plane_of_motion_3")
  final dynamic? planeOfMotion3;
  @JsonKey(name: "body_region")
  final String? bodyRegion;
  @JsonKey(name: "force_type")
  final String? forceType;
  @JsonKey(name: "mechanics")
  final String? mechanics;
  @JsonKey(name: "laterality")
  final String? laterality;
  @JsonKey(name: "primary_exercise_classification")
  final String? primaryExerciseClassification;
  @JsonKey(name: "short_youtube_demonstration_link")
  final String? shortYoutubeDemonstrationLink;
  @JsonKey(name: "in_depth_youtube_explanation_link")
  final String? inDepthYoutubeExplanationLink;

  ExerciseResponse ({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.PrimaryItems,
    this.secondaryEquipment,
    this.SecondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.movementPattern2,
    this.movementPattern3,
    this.planeOfMotion1,
    this.planeOfMotion2,
    this.planeOfMotion3,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) {
    return _$ExerciseResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExerciseResponseToJson(this);
  }

  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id,
      name: exercise,
      difficultyLevel: difficultyLevel,
      bodyRegion: bodyRegion,
      muscle: MuscleEntity(
        primeMover: primeMoverMuscle,
        secondary: secondaryMuscle?.toString(),
        tertiary: tertiaryMuscle?.toString(),
      ),
      equipment: EquipmentEntity(
        primaryEquipment: primaryEquipment,
        primaryItems: PrimaryItems,
        secondaryEquipment: secondaryEquipment?.toString(),
        secondaryItems: SecondaryItems,
      ),
      motion: MotionEntity(
        movementPattern: movementPattern1,
        planeOfMotion: planeOfMotion1,
        mechanics: mechanics,
        forceType: forceType,
        posture: posture,
      ),
      video: ExerciseVideoEntity(
        shortDemo: shortYoutubeDemonstration,
        inDepthExplanation: inDepthYoutubeExplanation,
        shortDemoLink: shortYoutubeDemonstrationLink,
        inDepthLink: inDepthYoutubeExplanationLink,
      ),
    );
  }
}

