import 'package:fitness/features/auth/api/models/auth_response/personal_info.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PersonalInfo toEntity tests", () {
    test(
      "when call toEntity with null values it should return PersonalInfoEntity with null values",
      () {
        // Arrange
        const PersonalInfo personalInfo = PersonalInfo(
          id: null,
          firstName: null,
          lastName: null,
          email: null,
          gender: null,
          age: null,
          photo: null,
        );

        // Act
        final PersonalInfoEntity actualResult = personalInfo.toEntity();

        // Assert
        expect(actualResult.id, isNull);
        expect(actualResult.firstName, isNull);
        expect(actualResult.lastName, isNull);
        expect(actualResult.email, isNull);
        expect(actualResult.gender, isNull);
        expect(actualResult.age, isNull);
        expect(actualResult.photo, isNull);
      },
    );

    test(
      "when call toEntity with non-nullable values it should return PersonalInfoEntity with correct values",
      () {
        // Arrange
        const PersonalInfo personalInfo = PersonalInfo(
          id: "123",
          firstName: "Omar",
          lastName: "Elsadany",
          email: "omar@example.com",
          gender: "male",
          age: 25,
          photo: "photo.png",
        );

        // Act
        final PersonalInfoEntity actualResult = personalInfo.toEntity();

        // Assert
        expect(actualResult.id, equals(personalInfo.id));
        expect(actualResult.firstName, equals(personalInfo.firstName));
        expect(actualResult.lastName, equals(personalInfo.lastName));
        expect(actualResult.email, equals(personalInfo.email));
        expect(actualResult.gender, equals(personalInfo.gender));
        expect(actualResult.age, equals(personalInfo.age));
        expect(actualResult.photo, equals(personalInfo.photo));
        expect(actualResult.id, equals("123"));
        expect(actualResult.firstName, equals("Omar"));
        expect(actualResult.lastName, equals("Elsadany"));
        expect(actualResult.email, equals("omar@example.com"));
        expect(actualResult.gender, equals("male"));
        expect(actualResult.age, equals(25));
        expect(actualResult.photo, equals("photo.png"));
      },
    );

    test(
      "when call toEntity with partial data it should return PersonalInfoEntity with correct partial values",
      () {
        // Arrange
        const PersonalInfo personalInfo = PersonalInfo(
          id: "456",
          firstName: "John",
          email: "john@example.com",
          age: 30,
        );

        // Act
        final PersonalInfoEntity actualResult = personalInfo.toEntity();

        // Assert
        expect(actualResult.id, equals("456"));
        expect(actualResult.firstName, equals("John"));
        expect(actualResult.lastName, isNull);
        expect(actualResult.email, equals("john@example.com"));
        expect(actualResult.gender, isNull);
        expect(actualResult.age, equals(30));
        expect(actualResult.photo, isNull);
      },
    );
  });

  group("PersonalInfo JSON serialization tests", () {
    test("toJson and fromJson should work correctly with all fields", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        id: "789",
        firstName: "Sarah",
        lastName: "Smith",
        email: "sarah@example.com",
        gender: "female",
        age: 28,
        photo: "profile.jpg",
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);

      // Assert
      expect(fromJson.id, equals(personalInfo.id));
      expect(fromJson.firstName, equals(personalInfo.firstName));
      expect(fromJson.lastName, equals(personalInfo.lastName));
      expect(fromJson.email, equals(personalInfo.email));
      expect(fromJson.gender, equals(personalInfo.gender));
      expect(fromJson.age, equals(personalInfo.age));
      expect(fromJson.photo, equals(personalInfo.photo));
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        id: null,
        firstName: null,
        lastName: null,
        email: null,
        gender: null,
        age: null,
        photo: null,
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);

      // Assert
      expect(fromJson.id, isNull);
      expect(fromJson.firstName, isNull);
      expect(fromJson.lastName, isNull);
      expect(fromJson.email, isNull);
      expect(fromJson.gender, isNull);
      expect(fromJson.age, isNull);
      expect(fromJson.photo, isNull);
    });

    // test("toJson should create correct JSON structure", () {
    //   // Arrange
    //   const PersonalInfo personalInfo = PersonalInfo(
    //     id: "101",
    //     firstName: "Ahmed",
    //     lastName: "Mohamed",
    //     email: "ahmed@example.com",
    //     gender: "male",
    //     age: 32,
    //     photo: "avatar.png",
    //   );

    //   // Act
    //   final json = personalInfo.toJson();

    //   // Assert
    //   expect(json, isA<Map<String, dynamic>>());
    //   expect(json.containsKey('id'), isTrue);
    //   expect(json.containsKey('firstName'), isTrue);
    //   expect(json.containsKey('lastName'), isTrue);
    //   expect(json.containsKey('email'), isTrue);
    //   expect(json.containsKey('gender'), isTrue);
    //   expect(json.containsKey('age'), isTrue);
    //   expect(json.containsKey('photo'), isTrue);
    //   expect(json['id'], equals("101"));
    //   expect(json['firstName'], equals("Ahmed"));
    //   expect(json['lastName'], equals("Mohamed"));
    //   expect(json['email'], equals("ahmed@example.com"));
    //   expect(json['gender'], equals("male"));
    //   expect(json['age'], equals(32));
    //   expect(json['photo'], equals("avatar.png"));
    // });

    test("fromJson should parse JSON correctly", () {
      // Arrange
      final json = {
        '_id': '202',
        'firstName': 'Emily',
        'lastName': 'Johnson',
        'email': 'emily@example.com',
        'gender': 'female',
        'age': 26,
        'photo': 'emily.jpg',
      };

      // Act
      final personalInfo = PersonalInfo.fromJson(json);

      // Assert
      expect(personalInfo.id, equals('202'));
      expect(personalInfo.firstName, equals('Emily'));
      expect(personalInfo.lastName, equals('Johnson'));
      expect(personalInfo.email, equals('emily@example.com'));
      expect(personalInfo.gender, equals('female'));
      expect(personalInfo.age, equals(26));
      expect(personalInfo.photo, equals('emily.jpg'));
    });

    test("fromJson should handle missing keys as null", () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final personalInfo = PersonalInfo.fromJson(json);

      // Assert
      expect(personalInfo.id, isNull);
      expect(personalInfo.firstName, isNull);
      expect(personalInfo.lastName, isNull);
      expect(personalInfo.email, isNull);
      expect(personalInfo.gender, isNull);
      expect(personalInfo.age, isNull);
      expect(personalInfo.photo, isNull);
    });

    test("fromJson should handle partial JSON with only required fields", () {
      // Arrange
      final json = {
        '_id': '303',
        'email': 'partial@example.com',
      };

      // Act
      final personalInfo = PersonalInfo.fromJson(json);

      // Assert
      expect(personalInfo.id, equals('303'));
      expect(personalInfo.firstName, isNull);
      expect(personalInfo.lastName, isNull);
      expect(personalInfo.email, equals('partial@example.com'));
      expect(personalInfo.gender, isNull);
      expect(personalInfo.age, isNull);
      expect(personalInfo.photo, isNull);
    });

    test("fromJson should handle partial JSON with string fields only", () {
      // Arrange
      final json = {
        'firstName': 'Mike',
        'lastName': 'Williams',
        'gender': 'male',
      };

      // Act
      final personalInfo = PersonalInfo.fromJson(json);

      // Assert
      expect(personalInfo.id, isNull);
      expect(personalInfo.firstName, equals('Mike'));
      expect(personalInfo.lastName, equals('Williams'));
      expect(personalInfo.email, isNull);
      expect(personalInfo.gender, equals('male'));
      expect(personalInfo.age, isNull);
      expect(personalInfo.photo, isNull);
    });

    test("fromJson should handle partial JSON with age only", () {
      // Arrange
      final json = {
        'age': 35,
      };

      // Act
      final personalInfo = PersonalInfo.fromJson(json);

      // Assert
      expect(personalInfo.id, isNull);
      expect(personalInfo.firstName, isNull);
      expect(personalInfo.lastName, isNull);
      expect(personalInfo.email, isNull);
      expect(personalInfo.gender, isNull);
      expect(personalInfo.age, equals(35));
      expect(personalInfo.photo, isNull);
    });
  });

  group("PersonalInfo edge cases", () {
    test("should handle empty string values", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        id: "",
        firstName: "",
        lastName: "",
        email: "",
        gender: "",
        age: 0,
        photo: "",
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);
      final entity = personalInfo.toEntity();

      // Assert
      expect(fromJson.id, equals(""));
      expect(fromJson.firstName, equals(""));
      expect(fromJson.lastName, equals(""));
      expect(fromJson.email, equals(""));
      expect(fromJson.gender, equals(""));
      expect(fromJson.age, equals(0));
      expect(fromJson.photo, equals(""));
      expect(entity.id, equals(""));
      expect(entity.firstName, equals(""));
    });

    test("should handle special characters in strings", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        id: "id-123-abc",
        firstName: "José",
        lastName: "O'Brien",
        email: "test+email@example.com",
        gender: "non-binary",
        age: 40,
        photo: "path/to/photo.png",
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);

      // Assert
      expect(fromJson.id, equals("id-123-abc"));
      expect(fromJson.firstName, equals("José"));
      expect(fromJson.lastName, equals("O'Brien"));
      expect(fromJson.email, equals("test+email@example.com"));
      expect(fromJson.gender, equals("non-binary"));
      expect(fromJson.age, equals(40));
      expect(fromJson.photo, equals("path/to/photo.png"));
    });

    test("should handle very long strings", () {
      // Arrange
      final longString = "a" * 1000;
      final PersonalInfo personalInfo = PersonalInfo(
        id: longString,
        firstName: longString,
        lastName: longString,
        email: "$longString@example.com",
        gender: longString,
        age: 25,
        photo: longString,
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);

      // Assert
      expect(fromJson.id, equals(longString));
      expect(fromJson.firstName, equals(longString));
      expect(fromJson.lastName, equals(longString));
    });

    test("should handle negative age", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        age: -5,
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);

      // Assert
      expect(fromJson.age, equals(-5));
    });

    test("should handle very large age value", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        age: 999,
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);

      // Assert
      expect(fromJson.age, equals(999));
    });

    test("should handle Unicode characters", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        firstName: "محمد",
        lastName: "李明",
        gender: "男性",
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);

      // Assert
      expect(fromJson.firstName, equals("محمد"));
      expect(fromJson.lastName, equals("李明"));
      expect(fromJson.gender, equals("男性"));
    });
  });

  group("PersonalInfo integration tests", () {
    test("complete round-trip with toEntity should preserve all data", () {
      // Arrange
      const PersonalInfo personalInfo = PersonalInfo(
        id: "round-trip-123",
        firstName: "Alice",
        lastName: "Wonder",
        email: "alice@wonderland.com",
        gender: "female",
        age: 24,
        photo: "alice.png",
      );

      // Act
      final json = personalInfo.toJson();
      final fromJson = PersonalInfo.fromJson(json);
      final entity = fromJson.toEntity();

      // Assert
      expect(entity.id, equals(personalInfo.id));
      expect(entity.firstName, equals(personalInfo.firstName));
      expect(entity.lastName, equals(personalInfo.lastName));
      expect(entity.email, equals(personalInfo.email));
      expect(entity.gender, equals(personalInfo.gender));
      expect(entity.age, equals(personalInfo.age));
      expect(entity.photo, equals(personalInfo.photo));
    });
  });
}