import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/api/models/auth_response/user_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toEntity", () {
    test(
      "when call toEntity with null values it should return authEntity with null values",
      () {
        // Arrange
        final AuthResponse authResponse = AuthResponse(
          message: null,
          token: null,
          user: null,
        );

        // Act
        final AuthEntity actualResult = authResponse.toEntity();

        // Assert
        expect(actualResult.message, equals(authResponse.message));
        expect(actualResult.token, equals(authResponse.token));
        expect(actualResult.user, equals(authResponse.user));
      },
    );

    test(
      "when call toEntity with non-nullable values it should return authEntity with correct values",
      () {
        // Arrange
        final AuthResponse authResponse = AuthResponse(
          message: "success",
          token: "12345token",
          user: UserResponse(
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
          ),
        );

        // Act
        final AuthEntity actualResult = authResponse.toEntity();

        // Assert
        expect(actualResult.message, equals(authResponse.message));
        expect(actualResult.token, equals(authResponse.token));
        expect(actualResult.user, isNotNull);
        expect(
          actualResult.user?.activityLevel,
          equals(authResponse.user?.activityLevel),
        );
        expect(
          actualResult.user?.createdAt,
          equals(authResponse.user?.createdAt),
        );
        expect(actualResult.user?.goal, equals(authResponse.user?.goal));

        expect(actualResult.user?.bodyInfo, isNotNull);
        expect(
          actualResult.user?.bodyInfo?.height,
          equals(authResponse.user?.height),
        );
        expect(
          actualResult.user?.bodyInfo?.weight,
          equals(authResponse.user?.weight),
        );

        expect(actualResult.user?.personalInfo, isNotNull);
        expect(
          actualResult.user?.personalInfo?.age,
          equals(authResponse.user?.age),
        );
        expect(
          actualResult.user?.personalInfo?.email,
          equals(authResponse.user?.email),
        );
        expect(
          actualResult.user?.personalInfo?.firstName,
          equals(authResponse.user?.firstName),
        );
        expect(
          actualResult.user?.personalInfo?.lastName,
          equals(authResponse.user?.lastName),
        );
        expect(
          actualResult.user?.personalInfo?.gender,
          equals(authResponse.user?.gender),
        );
        expect(
          actualResult.user?.personalInfo?.id,
          equals(authResponse.user?.id),
        );
        expect(
          actualResult.user?.personalInfo?.photo,
          equals(authResponse.user?.photo),
        );
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly with all fields", () {
      // Arrange
      final AuthResponse authResponse = AuthResponse(
        message: "success",
        token: "12345token",
        user: UserResponse(
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

        ),
      );

      // Act
      final json = authResponse.toJson();
      final fromJson = AuthResponse.fromJson(json);

      expect(fromJson.message, equals(authResponse.message));
      expect(fromJson.token, equals(authResponse.token));
      expect(fromJson.user, isNotNull);

      expect(
        fromJson.user?.activityLevel,
        equals(authResponse.user?.activityLevel),
      );
      expect(fromJson.user?.createdAt, equals(authResponse.user?.createdAt));
      expect(fromJson.user?.goal, equals(authResponse.user?.goal));

      expect(
        fromJson.user?.height,
        equals(authResponse.user?.height),
      );
      expect(
        fromJson.user?.weight,
        equals(authResponse.user?.weight),
      );

      expect(
        fromJson.user?.age,
        equals(authResponse.user?.age),
      );
      expect(
        fromJson.user?.email,
        equals(authResponse.user?.email),
      );
      expect(
        fromJson.user?.firstName,
        equals(authResponse.user?.firstName),
      );
      expect(
        fromJson.user?.lastName,
        equals(authResponse.user?.lastName),
      );
      expect(
        fromJson.user?.gender,
        equals(authResponse.user?.gender),
      );
      expect(
        fromJson.user?.id,
        equals(authResponse.user?.id),
      );
      expect(
        fromJson.user?.photo,
        equals(authResponse.user?.photo),
      );
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      final AuthResponse authResponse = AuthResponse(
        message: null,
        token: null,
        user: null,
      );

      // Act
      final json = authResponse.toJson();
      final fromJson = AuthResponse.fromJson(json);

      // Assert
      expect(fromJson.message, isNull);
      expect(fromJson.token, isNull);
      expect(fromJson.user, isNull);
    });
  });
}
