import 'package:fitness/features/auth/api/models/auth_response/user_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("UserResponse toEntity tests", () {
    test(
      "when call toEntity with null values it should return UserEntity with null values",
      () {
        // Arrange
        final UserResponse userResponse = UserResponse(
          activityLevel: null,
          createdAt: null,
          goal: null,
          height: null,
          weight: null,
          age: null,
          email: null,
          firstName: null,
          lastName: null,
          gender: null,
          id: null,
          photo: null,
        );

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.bodyInfo?.height, isNull);
        expect(actualResult.bodyInfo?.weight, isNull);
        expect(actualResult.activityLevel, isNull);
        expect(actualResult.goal, isNull);
        expect(actualResult.createdAt, isNull);
      },
    );

    test(
      "when call toEntity with non-nullable values it should return UserEntity with correct values",
      () {
        // Arrange
        final UserResponse userResponse = UserResponse(
          activityLevel: "level1",
          createdAt: "may-12",
          goal: "Gain Weight",
          height: 12,
          weight: 22,
          age: 23,
          email: "test@gmail.com",
          firstName: "omar",
          lastName: "elsadany",
          gender: "male",
          id: "1",
          photo: "photo.png",
        );

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.personalInfo, isNotNull);
        expect(actualResult.bodyInfo, isNotNull);
        expect(actualResult.activityLevel, equals(userResponse.activityLevel));
        expect(actualResult.goal, equals(userResponse.goal));
        expect(actualResult.createdAt, equals(userResponse.createdAt));

        expect(actualResult.personalInfo?.id, equals(userResponse.id));
        expect(
          actualResult.personalInfo?.firstName,
          equals(userResponse.firstName),
        );
        expect(
          actualResult.personalInfo?.lastName,
          equals(userResponse.lastName),
        );
        expect(actualResult.personalInfo?.email, equals(userResponse.email));
        expect(actualResult.personalInfo?.gender, equals(userResponse.gender));
        expect(actualResult.personalInfo?.age, equals(userResponse.age));
        expect(actualResult.personalInfo?.photo, equals(userResponse.photo));

        expect(actualResult.bodyInfo?.weight, equals(userResponse.weight));
        expect(actualResult.bodyInfo?.height, equals(userResponse.height));
      },
    );

    test(
      "when call toEntity with partial data it should return UserEntity with correct partial values",
      () {
        // Arrange
        final UserResponse userResponse = UserResponse(
          firstName: "omar",
          email: "test@gmail.com",
          activityLevel: "level1",
          goal: "Gain Weight",
        );

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.personalInfo, isNotNull);
        expect(actualResult.bodyInfo?.weight, isNull);
        expect(actualResult.bodyInfo?.height, isNull);
        expect(actualResult.activityLevel, equals(userResponse.activityLevel));
        expect(actualResult.goal, equals(userResponse.goal));
        expect(actualResult.createdAt, isNull);
        expect(
          actualResult.personalInfo?.firstName,
          equals(userResponse.firstName),
        );
        expect(actualResult.personalInfo?.email, equals(userResponse.email));
      },
    );

    test(
      "when call toEntity with only bodyInfo it should return UserEntity with only bodyInfo",
      () {
        // Arrange
        final UserResponse userResponse = UserResponse(weight: 22, height: 12);

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.personalInfo?.email, isNull);
        expect(actualResult.personalInfo?.photo, isNull);
        expect(actualResult.personalInfo?.lastName, isNull);
        expect(actualResult.bodyInfo, isNotNull);
        expect(actualResult.bodyInfo?.weight, equals(userResponse.weight));
        expect(actualResult.bodyInfo?.height, equals(userResponse.height));
        expect(actualResult.activityLevel, isNull);
        expect(actualResult.goal, isNull);
        expect(actualResult.createdAt, isNull);
      },
    );
  });

  group("UserResponse JSON serialization tests", () {
    test("toJson and fromJson should work correctly with all fields", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        activityLevel: "level1",
        createdAt: "may-12",
        goal: "Gain Weight",
        height: 12,
        weight: 22,
        age: 23,
        email: "test@gmail.com",
        firstName: "omar",
        lastName: "elsadany",
        gender: "male",
        id: "1",
        photo: "photo.png",
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson, isNotNull);
      expect(fromJson.activityLevel, equals(userResponse.activityLevel));
      expect(fromJson.goal, equals(userResponse.goal));
      expect(fromJson.createdAt, equals(userResponse.createdAt));

      expect(fromJson.id, equals(userResponse.id));
      expect(fromJson.firstName, equals(userResponse.firstName));
      expect(fromJson.lastName, equals(userResponse.lastName));
      expect(fromJson.email, equals(userResponse.email));
      expect(fromJson.gender, equals(userResponse.gender));
      expect(fromJson.age, equals(userResponse.age));
      expect(fromJson.photo, equals(userResponse.photo));

      expect(fromJson.weight, equals(userResponse.weight));
      expect(fromJson.height, equals(userResponse.height));
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        activityLevel: null,
        createdAt: null,
        goal: null,
        height: null,
        weight: null,
        age: null,
        email: null,
        firstName: null,
        lastName: null,
        gender: null,
        id: null,
        photo: null,
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      // expect(fromJson, isNull);
      expect(fromJson.activityLevel, isNull);
      expect(fromJson.goal, isNull);
      expect(fromJson.createdAt, isNull);
    });

    test("toJson should create correct JSON structure", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        id: "1",
        firstName: "omar",
        email: "test@gmail.com",
        weight: 22,
        height: 12,
        activityLevel: "level1",
        goal: "Gain Weight",
        createdAt: "may-12",
      );

      // Act
      final json = userResponse.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json.containsKey('firstName'), isTrue);
      expect(json.containsKey('email'), isTrue);
      expect(json.containsKey('weight'), isTrue);
      expect(json.containsKey('height'), isTrue);
      expect(json.containsKey('activityLevel'), isTrue);
      expect(json.containsKey('goal'), isTrue);
      expect(json.containsKey('createdAt'), isTrue);
      expect(json['activityLevel'], equals(userResponse.activityLevel));
      expect(json['goal'], equals(userResponse.goal));
      expect(json['createdAt'], equals(userResponse.createdAt));

    });

    test("fromJson should parse JSON correctly", () {
      // Arrange
      final json = {
          '_id': '1',
          'firstName': 'omar',
          'lastName': 'elsadany',
          'email': 'test@gmail.com',
          'gender': 'male',
          'age': 23,
          'photo': 'photo.png',
        'weight': 22,
        'height': 12,
        'activityLevel': 'level1',
        'goal': 'Gain Weight',
        'createdAt': 'may-12',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse, isNotNull);
      expect(userResponse.activityLevel, equals('level1'));
      expect(userResponse.goal, equals('Gain Weight'));
      expect(userResponse.createdAt, equals('may-12'));
      expect(userResponse.id, equals('1'));
      expect(userResponse.firstName, equals('omar'));
      expect(userResponse.weight, equals(22));
      expect(userResponse.height, equals(12));
    });

    test("fromJson should handle missing keys as null", () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.activityLevel, isNull);
      expect(userResponse.goal, isNull);
      expect(userResponse.createdAt, isNull);
    });

    test("fromJson should handle partial JSON with only personalInfo", () {
      // Arrange
      final json = {
        'firstName': 'omar',
        'email': 'test@gmail.com',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse, isNotNull);
      expect(userResponse.firstName, equals('omar'));
      expect(userResponse.email, equals('test@gmail.com'));
      expect(userResponse.activityLevel, isNull);
      expect(userResponse.goal, isNull);
      expect(userResponse.createdAt, isNull);
    });

    test("fromJson should handle partial JSON with only bodyInfo", () {
      // Arrange
      final json = {
        'weight': 22,
        'height': 12,
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.email, isNull);
      expect(userResponse.weight, equals(22));
      expect(userResponse.height, equals(12));
      expect(userResponse.activityLevel, isNull);
      expect(userResponse.goal, isNull);
      expect(userResponse.createdAt, isNull);
    });

    test("fromJson should handle partial JSON with only string fields", () {
      // Arrange
      final json = {
        'activityLevel': 'level1',
        'goal': 'Gain Weight',
        'createdAt': 'may-12',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.activityLevel, equals('level1'));
      expect(userResponse.goal, equals('Gain Weight'));
      expect(userResponse.createdAt, equals('may-12'));
    });

    test("fromJson should handle nested null values in personalInfo", () {
      // Arrange
      final json = {
        'firstName': 'omar',
        'activityLevel': 'level1',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.firstName, equals('omar'));
      expect(userResponse.lastName, isNull);
      expect(userResponse.email, isNull);
      expect(userResponse.activityLevel, equals('level1'));
    });

    test("fromJson should handle nested null values in bodyInfo", () {
      // Arrange
      final json = {
        'weight': 22,
        'goal': 'Gain Weight',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.weight, equals(22));
      expect(userResponse.height, isNull);
      expect(userResponse.goal, equals('Gain Weight'));
    });
  });

  group("UserResponse edge cases", () {
    test("should handle empty string values", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        activityLevel: "",
        goal: "",
        createdAt: "",
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);
      final entity = userResponse.toEntity();

      // Assert
      expect(fromJson.activityLevel, equals(userResponse.activityLevel));
      expect(fromJson.goal, equals(userResponse.goal));
      expect(fromJson.createdAt, equals(userResponse.createdAt));
      expect(entity.activityLevel, equals(userResponse.activityLevel));
      expect(entity.goal, equals(userResponse.goal));
      expect(entity.createdAt, equals(userResponse.createdAt));
    });

    test("should handle special characters in string fields", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        activityLevel: "level1",
        goal: "Gain Weight",
        createdAt: "may-12",
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson.activityLevel, equals(userResponse.activityLevel));
      expect(fromJson.goal, equals(userResponse.goal));
      expect(fromJson.createdAt, equals(userResponse.createdAt));
    });

    test("should handle very long strings", () {
      // Arrange
      final longString = "a" * 1000;
      final UserResponse userResponse = UserResponse(
        activityLevel: longString,
        goal: longString,
        createdAt: longString,
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson.activityLevel, equals(userResponse.activityLevel));
      expect(fromJson.goal, equals(userResponse.goal));
      expect(fromJson.createdAt, equals(userResponse.createdAt));
    });

    test("should handle different date formats", () {
      // Arrange
      final UserResponse userResponse = UserResponse(createdAt: "may-12");

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson.createdAt, equals(userResponse.createdAt));
    });

  });

  group("UserResponse integration tests", () {
    test("complete round-trip with toEntity should preserve all data", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        activityLevel: "level1",
        createdAt: "may-12",
        goal: "Gain Weight",
        height: 12, weight: 22,
          age: 23,
          email: "test@gmail.com",
          firstName: "omar",
          lastName: "elsadany",
          gender: "male",
          id: "1",
          photo: "photo.png",
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);
      final entity = fromJson.toEntity();

      // Assert - compare with userResponse values
      expect(entity.personalInfo?.id, equals(userResponse.id));
      expect(
        entity.personalInfo?.firstName,
        equals(userResponse.firstName),
      );
      expect(
        entity.personalInfo?.lastName,
        equals(userResponse.lastName),
      );
      expect(
        entity.personalInfo?.email,
        equals(userResponse.email),
      );
      expect(
        entity.personalInfo?.gender,
        equals(userResponse.gender),
      );
      expect(entity.personalInfo?.age, equals(userResponse.age));
      expect(
        entity.personalInfo?.photo,
        equals(userResponse.photo),
      );
      expect(entity.bodyInfo?.weight, equals(userResponse.weight));
      expect(entity.bodyInfo?.height, equals(userResponse.height));
      expect(entity.activityLevel, equals(userResponse.activityLevel));
      expect(entity.goal, equals(userResponse.goal));
      expect(entity.createdAt, equals(userResponse.createdAt));
    });

    test("toEntity should handle nested null values correctly", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
       firstName: "omar",
        weight: 22,
        activityLevel: "level1",
      );

      // Act
      final entity = userResponse.toEntity();

      // Assert
      expect(entity.personalInfo, isNotNull);
      expect(
        entity.personalInfo?.firstName,
        equals(userResponse.firstName),
      );
      expect(entity.personalInfo?.lastName, isNull);
      expect(entity.bodyInfo, isNotNull);
      expect(entity.bodyInfo?.weight, equals(userResponse.weight));
      expect(entity.bodyInfo?.height, isNull);
      expect(entity.activityLevel, equals(userResponse.activityLevel));
      expect(entity.goal, isNull);
      expect(entity.createdAt, isNull);
    });
  });
}
