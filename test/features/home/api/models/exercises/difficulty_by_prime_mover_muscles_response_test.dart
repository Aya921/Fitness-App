import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/home/api/models/exercises/difficulty_by_prime_mover_muscles_response.dart';
import 'package:fitness/features/home/api/models/exercises/level_response.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_by_prime_mover_muscles_entity.dart';

void main() {
  group('DifficultyByPrimeMoverMusclesResponse', () {
    final Map<String, dynamic> json = {
      "message": "Success",
      "totalLevels": 2,
      "difficulty_levels": [
        {"id": "1", "name": "Beginner"},
        {"id": "2", "name": "Intermediate"},
      ],
    };

    test('should deserialize from JSON correctly', () {
      final response = DifficultyByPrimeMoverMusclesResponse.fromJson(json);

      expect(response.message, "Success");
      expect(response.totalLevels, 2);
      expect(response.difficultyLevels, isA<List<LevelResponse>>());
      expect(response.difficultyLevels!.length, 2);
    });

    test('should serialize to JSON correctly', () {
      final response = DifficultyByPrimeMoverMusclesResponse.fromJson(json);
      final result = response.toJson();

      expect(result["message"], "Success");
      expect(result["totalLevels"], 2);
      expect(result["difficulty_levels"], isA<List<dynamic>>());
      expect(result["difficulty_levels"].length, 2);
    });

    test('should convert to DifficultyByPrimeMoverMusclesEntity correctly', () {
      final response = DifficultyByPrimeMoverMusclesResponse.fromJson(json);
      final entity = response.toEntity();

      expect(entity, isA<DifficultyByPrimeMoverMusclesEntity>());
      expect(entity.message, "Success");
      expect(entity.totalLevels, 2);
      expect(entity.difficultyLevels!.length, 2);
      expect(entity.difficultyLevels!.first, isA<LevelEntity>());
      expect(entity.difficultyLevels!.first.name, "Beginner");
    });

    test('should handle null values gracefully', () {
      final response = DifficultyByPrimeMoverMusclesResponse.fromJson({});
      final entity = response.toEntity();

      expect(entity.message, null);
      expect(entity.totalLevels, null);
      expect(entity.difficultyLevels, null);
    });
    
  });
}
