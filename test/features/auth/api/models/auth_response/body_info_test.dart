import 'package:fitness/features/auth/api/models/auth_response/body_info.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("BodyInfo toEntity tests", () {
    test(
      "when call toEntity with null values it should return BodyInfoEntity with null values",
      () {
        // Arrange
        const BodyInfo bodyInfo = BodyInfo(
          weight: null,
          height: null,
        );

        // Act
        final BodyInfoEntity actualResult = bodyInfo.toEntity();

        // Assert
        expect(actualResult.weight, equals(bodyInfo.weight));
        expect(actualResult.height, equals(bodyInfo.height));
        expect(actualResult.weight, isNull);
        expect(actualResult.height, isNull);
      },
    );

    test(
      "when call toEntity with non-nullable values it should return BodyInfoEntity with correct values",
      () {
        // Arrange
        const BodyInfo bodyInfo = BodyInfo(
          weight: 75,
          height: 180,
        );

        // Act
        final BodyInfoEntity actualResult = bodyInfo.toEntity();

        // Assert
        expect(actualResult.weight, equals(bodyInfo.weight));
        expect(actualResult.height, equals(bodyInfo.height));
        expect(actualResult.weight, equals(75));
        expect(actualResult.height, equals(180));
      },
    );

    test(
      "when call toEntity with only weight it should return BodyInfoEntity with weight and null height",
      () {
        // Arrange
        const BodyInfo bodyInfo = BodyInfo(
          weight: 70,
          height: null,
        );

        // Act
        final BodyInfoEntity actualResult = bodyInfo.toEntity();

        // Assert
        expect(actualResult.weight, equals(70));
        expect(actualResult.height, isNull);
      },
    );

    test(
      "when call toEntity with only height it should return BodyInfoEntity with height and null weight",
      () {
        // Arrange
        const BodyInfo bodyInfo = BodyInfo(
          weight: null,
          height: 175,
        );

        // Act
        final BodyInfoEntity actualResult = bodyInfo.toEntity();

        // Assert
        expect(actualResult.weight, isNull);
        expect(actualResult.height, equals(175));
      },
    );
  });

  group("BodyInfo JSON serialization tests", () {
    test("toJson and fromJson should work correctly with all fields", () {
      // Arrange
      const BodyInfo bodyInfo = BodyInfo(
        weight: 80,
        height: 185,
      );

      // Act
      final json = bodyInfo.toJson();
      final fromJson = BodyInfo.fromJson(json);

      // Assert
      expect(fromJson.weight, equals(bodyInfo.weight));
      expect(fromJson.height, equals(bodyInfo.height));
      expect(fromJson.weight, equals(80));
      expect(fromJson.height, equals(185));
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      const BodyInfo bodyInfo = BodyInfo(
        weight: null,
        height: null,
      );

      // Act
      final json = bodyInfo.toJson();
      final fromJson = BodyInfo.fromJson(json);

      // Assert
      expect(fromJson.weight, isNull);
      expect(fromJson.height, isNull);
    });

    test("toJson should create correct JSON structure", () {
      // Arrange
      const BodyInfo bodyInfo = BodyInfo(
        weight: 65,
        height: 170,
      );

      // Act
      final json = bodyInfo.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json.containsKey('weight'), isTrue);
      expect(json.containsKey('height'), isTrue);
      expect(json['weight'], equals(65));
      expect(json['height'], equals(170));
    });

    test("fromJson should parse JSON correctly", () {
      // Arrange
      final json = {
        'weight': 90,
        'height': 195,
      };

      // Act
      final bodyInfo = BodyInfo.fromJson(json);

      // Assert
      expect(bodyInfo.weight, equals(90));
      expect(bodyInfo.height, equals(195));
    });

    test("fromJson should handle missing keys as null", () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final bodyInfo = BodyInfo.fromJson(json);

      // Assert
      expect(bodyInfo.weight, isNull);
      expect(bodyInfo.height, isNull);
    });

    test("fromJson should handle partial JSON with only weight", () {
      // Arrange
      final json = {'weight': 55};

      // Act
      final bodyInfo = BodyInfo.fromJson(json);

      // Assert
      expect(bodyInfo.weight, equals(55));
      expect(bodyInfo.height, isNull);
    });

    test("fromJson should handle partial JSON with only height", () {
      // Arrange
      final json = {'height': 160};

      // Act
      final bodyInfo = BodyInfo.fromJson(json);

      // Assert
      expect(bodyInfo.weight, isNull);
      expect(bodyInfo.height, equals(160));
    });
  });

  group("BodyInfo edge cases", () {
    test("should handle zero values", () {
      // Arrange
      const BodyInfo bodyInfo = BodyInfo(
        weight: 0,
        height: 0,
      );

      // Act
      final json = bodyInfo.toJson();
      final fromJson = BodyInfo.fromJson(json);
      final entity = bodyInfo.toEntity();

      // Assert
      expect(fromJson.weight, equals(0));
      expect(fromJson.height, equals(0));
      expect(entity.weight, equals(0));
      expect(entity.height, equals(0));
    });

    test("should handle negative values", () {
      // Arrange
      const BodyInfo bodyInfo = BodyInfo(
        weight: -10,
        height: -20,
      );

      // Act
      final json = bodyInfo.toJson();
      final fromJson = BodyInfo.fromJson(json);

      // Assert
      expect(fromJson.weight, equals(-10));
      expect(fromJson.height, equals(-20));
    });

    test("should handle very large values", () {
      // Arrange
      const BodyInfo bodyInfo = BodyInfo(
        weight: 999999,
        height: 999999,
      );

      // Act
      final json = bodyInfo.toJson();
      final fromJson = BodyInfo.fromJson(json);

      // Assert
      expect(fromJson.weight, equals(999999));
      expect(fromJson.height, equals(999999));
    });
  });
}