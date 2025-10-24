import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/api/models/auth_response/body_info.dart';
import 'package:fitness/features/auth/api/models/auth_response/personal_info.dart';
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
          user: null
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
          )
        );

        // Act
        final AuthEntity actualResult = authResponse.toEntity();

        // Assert
        expect(actualResult.message, equals(authResponse.message));
        expect(actualResult.token, equals(authResponse.token));
        expect(actualResult.user, isNotNull);
        expect(actualResult.user?.activityLevel, equals(authResponse.user?.activityLevel));
        expect(actualResult.user?.createdAt, equals(authResponse.user?.createdAt));
        expect(actualResult.user?.goal, equals(authResponse.user?.goal));
      
        expect(actualResult.user?.bodyInfo, isNotNull);
        expect(actualResult.user?.bodyInfo?.height, equals(authResponse.user?.bodyInfo?.height));
        expect(actualResult.user?.bodyInfo?.weight, equals(authResponse.user?.bodyInfo?.weight));
      
        expect(actualResult.user?.personalInfo, isNotNull);
        expect(actualResult.user?.personalInfo?.age, equals(authResponse.user?.personalInfo?.age));
        expect(actualResult.user?.personalInfo?.email, equals(authResponse.user?.personalInfo?.email));
        expect(actualResult.user?.personalInfo?.firstName, equals(authResponse.user?.personalInfo?.firstName));
        expect(actualResult.user?.personalInfo?.lastName, equals(authResponse.user?.personalInfo?.lastName));
        expect(actualResult.user?.personalInfo?.gender, equals(authResponse.user?.personalInfo?.gender));
        expect(actualResult.user?.personalInfo?.id, equals(authResponse.user?.personalInfo?.id));
        expect(actualResult.user?.personalInfo?.photo, equals(authResponse.user?.personalInfo?.photo));
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
          )
        );

      // Act
      final json = authResponse.toJson();
      final fromJson = AuthResponse.fromJson(json);

      expect(fromJson.message, equals(authResponse.message));
      expect(fromJson.token, equals(authResponse.token));
      expect(fromJson.user, isNotNull);
    
      expect(fromJson.user?.activityLevel, equals(authResponse.user?.activityLevel));
      expect(fromJson.user?.createdAt, equals(authResponse.user?.createdAt));
      expect(fromJson.user?.goal, equals(authResponse.user?.goal));
      
      expect(fromJson.user?.bodyInfo, isNotNull);
      expect(fromJson.user?.bodyInfo?.height, equals(authResponse.user?.bodyInfo?.height));
      expect(fromJson.user?.bodyInfo?.weight, equals(authResponse.user?.bodyInfo?.weight));
      
      expect(fromJson.user?.personalInfo, isNotNull);
      expect(fromJson.user?.personalInfo?.age, equals(authResponse.user?.personalInfo?.age));
      expect(fromJson.user?.personalInfo?.email, equals(authResponse.user?.personalInfo?.email));
      expect(fromJson.user?.personalInfo?.firstName, equals(authResponse.user?.personalInfo?.firstName));
      expect(fromJson.user?.personalInfo?.lastName, equals(authResponse.user?.personalInfo?.lastName));
      expect(fromJson.user?.personalInfo?.gender, equals(authResponse.user?.personalInfo?.gender));
      expect(fromJson.user?.personalInfo?.id, equals(authResponse.user?.personalInfo?.id));
      expect(fromJson.user?.personalInfo?.photo, equals(authResponse.user?.personalInfo?.photo));
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      final AuthResponse authResponse = AuthResponse(
        message: null,
        token: null,
        user: null
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