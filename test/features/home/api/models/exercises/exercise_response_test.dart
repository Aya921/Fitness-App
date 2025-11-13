import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/home/api/models/exercises/exercise_response.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';

void main() {
  group('ExerciseResponse', () {
    // JSON mock data
    final Map<String, dynamic> json = {
      "_id": "1",
      "exercise": "Push Up",
      "difficulty_level": "Medium",
      "body_region": "Chest",
      "prime_mover_muscle": "Pectoralis Major",
      "secondary_muscle": "Triceps",
      "tertiary_muscle": "Deltoids",
      "primary_equipment": "Bodyweight",
      "_primary_items": 0,
      "secondary_equipment": "None",
      "_secondary_items": 0,
      "mechanics": "Compound",
      "force_type": "Push",
      "movement_pattern_1": "Horizontal Press",
      "plane_of_motion_1": "Transverse",
      "posture": "Standing",
      "short_youtube_demonstration": "Short video desc",
      "in_depth_youtube_explanation": "In depth desc",
      "short_youtube_demonstration_link": "https://short.com",
      "in_depth_youtube_explanation_link": "https://long.com",
    };

    test('should deserialize from JSON correctly', () {
      final response = ExerciseResponse.fromJson(json);

      expect(response.id, "1");
      expect(response.exercise, "Push Up");
      expect(response.difficultyLevel, "Medium");
      expect(response.bodyRegion, "Chest");
      expect(response.primeMoverMuscle, "Pectoralis Major");
      expect(response.mechanics, "Compound");
    });

    test('should serialize to JSON correctly', () {
      final response = ExerciseResponse.fromJson(json);
      final result = response.toJson();

      expect(result["_id"], "1");
      expect(result["exercise"], "Push Up");
      expect(result["difficulty_level"], "Medium");
      expect(result["body_region"], "Chest");
    });

    test('should convert to ExerciseEntity correctly', () {
      final response = ExerciseResponse.fromJson(json);
      final entity = response.toEntity();

      expect(entity, isA<ExerciseEntity>());
      expect(entity.id, "1");
      expect(entity.name, "Push Up");
      expect(entity.difficultyLevel, "Medium");
      expect(entity.bodyRegion, "Chest");

      expect(entity.muscle?.primeMover, "Pectoralis Major");
      expect(entity.muscle?.secondary, "Triceps");
      expect(entity.equipment?.primaryEquipment, "Bodyweight");

      expect(entity.video?.shortDemoLink, "https://short.com");
      expect(entity.video?.inDepthLink, "https://long.com");
    });
  });
}
