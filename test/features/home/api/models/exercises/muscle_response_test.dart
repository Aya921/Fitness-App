import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/home/api/models/exercises/muscle_response.dart';
import 'package:fitness/features/home/domain/entity/exercises/mover_muscle_entity.dart';

void main() {
  group('MuscleResponse', () {
    final Map<String, dynamic> json = {
      "_id": "123",
      "name": "Biceps",
      "image": "biceps.png",
    };

    test('should deserialize from JSON correctly', () {
      final response = MuscleResponse.fromJson(json);

      expect(response.id, "123");
      expect(response.name, "Biceps");
      expect(response.image, "biceps.png");
    });

    test('should serialize to JSON correctly', () {
      final response = MuscleResponse.fromJson(json);
      final result = response.toJson();

      expect(result["_id"], "123");
      expect(result["name"], "Biceps");
      expect(result["image"], "biceps.png");
    });

    test('should convert to MoverMuscleEntity correctly', () {
      final response = MuscleResponse.fromJson(json);
      final entity = response.toEntity();

      expect(entity, isA<MoverMuscleEntity>());
      expect(entity.id, "123");
      expect(entity.name, "Biceps");
      expect(entity.image, "biceps.png");
    });

    test('should handle null values gracefully and return empty strings', () {
      final response = MuscleResponse.fromJson({});
      final entity = response.toEntity();

      expect(entity.id, '');
      expect(entity.name, '');
      expect(entity.image, '');
    });

    test('should support JSON round-trip (serialization -> deserialization)', () {
      final original = MuscleResponse.fromJson(json);
      final roundTrip = MuscleResponse.fromJson(original.toJson());

      expect(roundTrip.id, original.id);
      expect(roundTrip.name, original.name);
      expect(roundTrip.image, original.image);
    });
  });
}
