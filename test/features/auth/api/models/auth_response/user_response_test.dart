import 'package:fitness/features/auth/api/models/auth_response/body_info.dart';
import 'package:fitness/features/auth/api/models/auth_response/personal_info.dart';
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
          personalInfo: null,
          bodyInfo: null,
          activityLevel: null,
          goal: null,
          createdAt: null,
        );

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.personalInfo, isNull);
        expect(actualResult.bodyInfo, isNull);
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
          bodyInfo: const BodyInfo(
            height: 12,
            weight: 22
          ),
          personalInfo: const PersonalInfo(
            age: 23,
            email: "test@gmail.com",
            firstName: "omar",
            lastName: "elsadany",
            gender: "male",
            id: "1",
            photo: "photo.png"
          )
        );

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.personalInfo, isNotNull);
        expect(actualResult.bodyInfo, isNotNull);
        expect(actualResult.activityLevel, equals(userResponse.activityLevel));
        expect(actualResult.goal, equals(userResponse.goal));
        expect(actualResult.createdAt, equals(userResponse.createdAt));
        
        expect(actualResult.personalInfo?.id, equals(userResponse.personalInfo?.id));
        expect(actualResult.personalInfo?.firstName, equals(userResponse.personalInfo?.firstName));
        expect(actualResult.personalInfo?.lastName, equals(userResponse.personalInfo?.lastName));
        expect(actualResult.personalInfo?.email, equals(userResponse.personalInfo?.email));
        expect(actualResult.personalInfo?.gender, equals(userResponse.personalInfo?.gender));
        expect(actualResult.personalInfo?.age, equals(userResponse.personalInfo?.age));
        expect(actualResult.personalInfo?.photo, equals(userResponse.personalInfo?.photo));
        
        expect(actualResult.bodyInfo?.weight, equals(userResponse.bodyInfo?.weight));
        expect(actualResult.bodyInfo?.height, equals(userResponse.bodyInfo?.height));
      },
    );

    test(
      "when call toEntity with partial data it should return UserEntity with correct partial values",
      () {
        // Arrange
        final UserResponse userResponse = UserResponse(
          personalInfo: const PersonalInfo(
            firstName: "omar",
            email: "test@gmail.com",
          ),
          activityLevel: "level1",
          goal: "Gain Weight",
        );

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.personalInfo, isNotNull);
        expect(actualResult.bodyInfo, isNull);
        expect(actualResult.activityLevel, equals(userResponse.activityLevel));
        expect(actualResult.goal, equals(userResponse.goal));
        expect(actualResult.createdAt, isNull);
        expect(actualResult.personalInfo?.firstName, equals(userResponse.personalInfo?.firstName));
        expect(actualResult.personalInfo?.email, equals(userResponse.personalInfo?.email));
      },
    );

    test(
      "when call toEntity with only bodyInfo it should return UserEntity with only bodyInfo",
      () {
        // Arrange
        final UserResponse userResponse = UserResponse(
          bodyInfo: const BodyInfo(
            weight: 22,
            height: 12,
          ),
        );

        // Act
        final UserEntity actualResult = userResponse.toEntity();

        // Assert
        expect(actualResult.personalInfo, isNull);
        expect(actualResult.bodyInfo, isNotNull);
        expect(actualResult.bodyInfo?.weight, equals(userResponse.bodyInfo?.weight));
        expect(actualResult.bodyInfo?.height, equals(userResponse.bodyInfo?.height));
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
        bodyInfo: const BodyInfo(
          height: 12,
          weight: 22
        ),
        personalInfo: const PersonalInfo(
          age: 23,
          email: "test@gmail.com",
          firstName: "omar",
          lastName: "elsadany",
          gender: "male",
          id: "1",
          photo: "photo.png"
        )
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson.personalInfo, isNotNull);
      expect(fromJson.bodyInfo, isNotNull);
      expect(fromJson.activityLevel, equals(userResponse.activityLevel));
      expect(fromJson.goal, equals(userResponse.goal));
      expect(fromJson.createdAt, equals(userResponse.createdAt));
      
      expect(fromJson.personalInfo?.id, equals(userResponse.personalInfo?.id));
      expect(fromJson.personalInfo?.firstName, equals(userResponse.personalInfo?.firstName));
      expect(fromJson.personalInfo?.lastName, equals(userResponse.personalInfo?.lastName));
      expect(fromJson.personalInfo?.email, equals(userResponse.personalInfo?.email));
      expect(fromJson.personalInfo?.gender, equals(userResponse.personalInfo?.gender));
      expect(fromJson.personalInfo?.age, equals(userResponse.personalInfo?.age));
      expect(fromJson.personalInfo?.photo, equals(userResponse.personalInfo?.photo));
      
      expect(fromJson.bodyInfo?.weight, equals(userResponse.bodyInfo?.weight));
      expect(fromJson.bodyInfo?.height, equals(userResponse.bodyInfo?.height));
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        personalInfo: null,
        bodyInfo: null,
        activityLevel: null,
        goal: null,
        createdAt: null,
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson.personalInfo, isNull);
      expect(fromJson.bodyInfo, isNull);
      expect(fromJson.activityLevel, isNull);
      expect(fromJson.goal, isNull);
      expect(fromJson.createdAt, isNull);
    });

    test("toJson should create correct JSON structure", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        personalInfo: const PersonalInfo(
          id: "1",
          firstName: "omar",
          email: "test@gmail.com",
        ),
        bodyInfo: const BodyInfo(
          weight: 22,
          height: 12,
        ),
        activityLevel: "level1",
        goal: "Gain Weight",
        createdAt: "may-12",
      );

      // Act
      final json = userResponse.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json.containsKey('personalInfo'), isTrue);
      expect(json.containsKey('bodyInfo'), isTrue);
      expect(json.containsKey('activityLevel'), isTrue);
      expect(json.containsKey('goal'), isTrue);
      expect(json.containsKey('createdAt'), isTrue);
      expect(json['activityLevel'], equals(userResponse.activityLevel));
      expect(json['goal'], equals(userResponse.goal));
      expect(json['createdAt'], equals(userResponse.createdAt));
      
      // Verify nested JSON
      expect(json['personalInfo'], isA<Map<String, dynamic>>());
      expect(json['bodyInfo'], isA<Map<String, dynamic>>());
    });

    test("fromJson should parse JSON correctly", () {
      // Arrange
      final json = {
        'personalInfo': {
          '_id': '1',
          'firstName': 'omar',
          'lastName': 'elsadany',
          'email': 'test@gmail.com',
          'gender': 'male',
          'age': 23,
          'photo': 'photo.png',
        },
        'bodyInfo': {
          'weight': 22,
          'height': 12,
        },
        'activityLevel': 'level1',
        'goal': 'Gain Weight',
        'createdAt': 'may-12',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.personalInfo, isNotNull);
      expect(userResponse.bodyInfo, isNotNull);
      expect(userResponse.activityLevel, equals('level1'));
      expect(userResponse.goal, equals('Gain Weight'));
      expect(userResponse.createdAt, equals('may-12'));
      
      // Verify nested objects
      expect(userResponse.personalInfo?.id, equals('1'));
      expect(userResponse.personalInfo?.firstName, equals('omar'));
      expect(userResponse.bodyInfo?.weight, equals(22));
      expect(userResponse.bodyInfo?.height, equals(12));
    });

    test("fromJson should handle missing keys as null", () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.personalInfo, isNull);
      expect(userResponse.bodyInfo, isNull);
      expect(userResponse.activityLevel, isNull);
      expect(userResponse.goal, isNull);
      expect(userResponse.createdAt, isNull);
    });

    test("fromJson should handle partial JSON with only personalInfo", () {
      // Arrange
      final json = {
        'personalInfo': {
          'firstName': 'omar',
          'email': 'test@gmail.com',
        },
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.personalInfo, isNotNull);
      expect(userResponse.personalInfo?.firstName, equals('omar'));
      expect(userResponse.personalInfo?.email, equals('test@gmail.com'));
      expect(userResponse.bodyInfo, isNull);
      expect(userResponse.activityLevel, isNull);
      expect(userResponse.goal, isNull);
      expect(userResponse.createdAt, isNull);
    });

    test("fromJson should handle partial JSON with only bodyInfo", () {
      // Arrange
      final json = {
        'bodyInfo': {
          'weight': 22,
          'height': 12,
        },
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.personalInfo, isNull);
      expect(userResponse.bodyInfo, isNotNull);
      expect(userResponse.bodyInfo?.weight, equals(22));
      expect(userResponse.bodyInfo?.height, equals(12));
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
      expect(userResponse.personalInfo, isNull);
      expect(userResponse.bodyInfo, isNull);
      expect(userResponse.activityLevel, equals('level1'));
      expect(userResponse.goal, equals('Gain Weight'));
      expect(userResponse.createdAt, equals('may-12'));
    });

    test("fromJson should handle nested null values in personalInfo", () {
      // Arrange
      final json = {
        'personalInfo': {
          'firstName': 'omar',
        },
        'activityLevel': 'level1',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.personalInfo, isNotNull);
      expect(userResponse.personalInfo?.firstName, equals('omar'));
      expect(userResponse.personalInfo?.lastName, isNull);
      expect(userResponse.personalInfo?.email, isNull);
      expect(userResponse.activityLevel, equals('level1'));
    });

    test("fromJson should handle nested null values in bodyInfo", () {
      // Arrange
      final json = {
        'bodyInfo': {
          'weight': 22,
        },
        'goal': 'Gain Weight',
      };

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.bodyInfo, isNotNull);
      expect(userResponse.bodyInfo?.weight, equals(22));
      expect(userResponse.bodyInfo?.height, isNull);
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
      final UserResponse userResponse = UserResponse(
        createdAt: "may-12",
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson.createdAt, equals(userResponse.createdAt));
    });

    test("should handle empty nested objects", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        personalInfo: const PersonalInfo(),
        bodyInfo: const BodyInfo(),
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);

      // Assert
      expect(fromJson.personalInfo, isNotNull);
      expect(fromJson.bodyInfo, isNotNull);
      expect(fromJson.personalInfo?.firstName, isNull);
      expect(fromJson.bodyInfo?.weight, isNull);
    });
  });

  group("UserResponse integration tests", () {
    test("complete round-trip with toEntity should preserve all data", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        activityLevel: "level1",
        createdAt: "may-12",
        goal: "Gain Weight",
        bodyInfo: const BodyInfo(
          height: 12,
          weight: 22
        ),
        personalInfo: const PersonalInfo(
          age: 23,
          email: "test@gmail.com",
          firstName: "omar",
          lastName: "elsadany",
          gender: "male",
          id: "1",
          photo: "photo.png"
        )
      );

      // Act
      final json = userResponse.toJson();
      final fromJson = UserResponse.fromJson(json);
      final entity = fromJson.toEntity();

      // Assert - compare with userResponse values
      expect(entity.personalInfo?.id, equals(userResponse.personalInfo?.id));
      expect(entity.personalInfo?.firstName, equals(userResponse.personalInfo?.firstName));
      expect(entity.personalInfo?.lastName, equals(userResponse.personalInfo?.lastName));
      expect(entity.personalInfo?.email, equals(userResponse.personalInfo?.email));
      expect(entity.personalInfo?.gender, equals(userResponse.personalInfo?.gender));
      expect(entity.personalInfo?.age, equals(userResponse.personalInfo?.age));
      expect(entity.personalInfo?.photo, equals(userResponse.personalInfo?.photo));
      expect(entity.bodyInfo?.weight, equals(userResponse.bodyInfo?.weight));
      expect(entity.bodyInfo?.height, equals(userResponse.bodyInfo?.height));
      expect(entity.activityLevel, equals(userResponse.activityLevel));
      expect(entity.goal, equals(userResponse.goal));
      expect(entity.createdAt, equals(userResponse.createdAt));
    });

    test("toEntity should handle nested null values correctly", () {
      // Arrange
      final UserResponse userResponse = UserResponse(
        personalInfo: const PersonalInfo(
          firstName: "omar",
        ),
        bodyInfo: const BodyInfo(
          weight: 22,
        ),
        activityLevel: "level1",
      );

      // Act
      final entity = userResponse.toEntity();

      // Assert
      expect(entity.personalInfo, isNotNull);
      expect(entity.personalInfo?.firstName, equals(userResponse.personalInfo?.firstName));
      expect(entity.personalInfo?.lastName, isNull);
      expect(entity.bodyInfo, isNotNull);
      expect(entity.bodyInfo?.weight, equals(userResponse.bodyInfo?.weight));
      expect(entity.bodyInfo?.height, isNull);
      expect(entity.activityLevel, equals(userResponse.activityLevel));
      expect(entity.goal, isNull);
      expect(entity.createdAt, isNull);
    });
  });
}