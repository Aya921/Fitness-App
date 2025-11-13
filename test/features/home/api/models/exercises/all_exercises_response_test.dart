import 'package:fitness/features/home/domain/entity/exercises/all_exercises_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/home/api/models/exercises/all_exercises_response.dart';
import 'package:fitness/features/home/api/models/exercises/exercise_response.dart';

void main() {
  group('AllExercisesResponse', () {
    final exerciseJson = {
      "_id": "1",
      "exercise": "Push Up",
      "difficulty_level": "Medium",
      "body_region": "Chest",
      "prime_mover_muscle": "Pectoralis Major",
      "mechanics": "Compound",
      "force_type": "Push",
      "movement_pattern_1": "Horizontal Press",
      "plane_of_motion_1": "Transverse",
      "short_youtube_demonstration": "Short video",
      "in_depth_youtube_explanation": "Long video",
      "short_youtube_demonstration_link": "https://short.com",
      "in_depth_youtube_explanation_link": "https://long.com",
    };

    final jsonData = {
      "message": "success",
      "totalExercises": 1,
      "totalPages": 1,
      "currentPage": 1,
      "exercises": [exerciseJson],
    };

    test('should deserialize from JSON correctly', () {
      final response = AllExercisesResponse.fromJson(jsonData);

      expect(response.message, "success");
      expect(response.totalExercises, 1);
      expect(response.exercises, isA<List<ExerciseResponse>>());
      expect(response.exercises!.first.exercise, "Push Up");
    });

    test('should serialize to JSON correctly', () {
      final response = AllExercisesResponse.fromJson(jsonData);
      final result = response.toJson();

      expect(result["message"], "success");
      expect(result["totalExercises"], 1);
      expect(result["exercises"], isA<List<dynamic>>());
    });

    test('should convert to entity correctly', () {
      final response = AllExercisesResponse.fromJson(jsonData);
      final entity = response.toEntity();

      expect(entity, isA<AllExercisesEntity>());
      expect(entity.exercises!.first.name, "Push Up");
      expect(entity.exercises!.first.bodyRegion, "Chest");
      expect(entity.exercises!.first.muscle?.primeMover, "Pectoralis Major");
    });
  });
}
