import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/home/api/models/exercises/level_response.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';

void main() {
  group('LevelResponse', () {
    final Map<String, dynamic> json = {
      "id": "1",
      "name": "Beginner",
    };

    test('should deserialize from JSON correctly', () {
      final response = LevelResponse.fromJson(json);

      expect(response.id, "1");
      expect(response.name, "Beginner");
    });

    test('should serialize to JSON correctly', () {
      final response = LevelResponse.fromJson(json);
      final result = response.toJson();

      expect(result["id"], "1");
      expect(result["name"], "Beginner");
    });

    test('should convert to LevelEntity correctly', () {
      final response = LevelResponse.fromJson(json);
      final entity = response.toEntity();

      expect(entity, isA<LevelEntity>());
      expect(entity.id, "1");
      expect(entity.name, "Beginner");
    });

    test('should handle null values', () {
      final response = LevelResponse.fromJson({});
      expect(response.id, isNull);
      expect(response.name, isNull);

      final entity = response.toEntity();
      expect(entity.id, isNull);
      expect(entity.name, isNull);
    });
  });
}
