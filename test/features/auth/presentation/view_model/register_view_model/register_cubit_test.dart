
import 'package:fitness/core/enum/levels.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/domain/use_case/register_use_case.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../../fake_form_state.dart';
import 'register_cubit_test.mocks.dart';
@GenerateMocks([RegisterUseCase])
void main() {
   TestWidgetsFlutterBinding.ensureInitialized();
  late RegisterCubit registerCubit;
  late MockRegisterUseCase mockRegisterUseCase;
  late Result<UserEntity> expectedRegisterSuccessResult;
  late FailedResult<UserEntity> expectedRegisterFailureResult;
 setUpAll((){
   mockRegisterUseCase = MockRegisterUseCase();
const userEntity = UserEntity(
      personalInfo: PersonalInfoEntity(
        id: "1",
        firstName: "omar",
        lastName: "elsadany",
        email: "test@gmail.com",
        gender: "male",
        age: 23,
        photo: "photo.png",
      ),
      bodyInfo: BodyInfoEntity(
        weight: 22,
        height: 12,
      ),
      activityLevel: "level1",
      goal: "Gain Weight",
      createdAt: "may-12",
    );
    expectedRegisterSuccessResult =  SuccessResult<UserEntity>(userEntity);
    expectedRegisterFailureResult = FailedResult<UserEntity>("failed");
     provideDummy<Result<UserEntity>>(expectedRegisterSuccessResult);
    provideDummy<Result<UserEntity>>(expectedRegisterFailureResult);
  });
  setUp(() {
  
    registerCubit = RegisterCubit(mockRegisterUseCase);
    registerCubit.doIntent(intent: const RegisterInitializationIntent());
    registerCubit.registerFormKey =FakeGlobalKey(FakeFormState());
    
  });

   group('RegisterCubit initialization', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits initial state when RegisterInitializationIntent is called',
      build: () => registerCubit,
      act: (cubit) {}, // No action needed - already initialized in setUp
      verify: (cubit) {
        expect(cubit.firstNameController, isNotNull);
        expect(cubit.lastNameController, isNotNull);
        expect(cubit.emailController, isNotNull);
        expect(cubit.passwordController, isNotNull);
        expect(cubit.registerFormKey, isNotNull);
      },
    );
  });

  group('RegisterCubit gender selection', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits state with selected gender when ChangeGenderIntent is called',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const ChangeGenderIntent(selectedGender: 'male'),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedGender,
          'selectedGender',
          equals('male'),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits state with female gender when ChangeGenderIntent is called with female',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const ChangeGenderIntent(selectedGender: 'female'),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedGender,
          'selectedGender',
          equals('female'),
        ),
      ],
    );
  });

  group('RegisterCubit password visibility', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits state with toggled isObscure when ToggleObscurePasswordIntent is called',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(intent: const ToggleObscurePasswordIntent()),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.isObscure,
          'isObscure',
          equals(false),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits state with isObscure toggled twice returns to original state',
      build: () => registerCubit,
      act: (cubit) => [
        cubit.doIntent(intent: const ToggleObscurePasswordIntent()),
        cubit.doIntent(intent: const ToggleObscurePasswordIntent()),
      ],
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.isObscure,
          'isObscure',
          equals(false),
        ),
        isA<RegisterState>().having(
          (state) => state.isObscure,
          'isObscure',
          equals(true),
        ),
      ],
    );
  });

  group('RegisterCubit body info selection', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits state with selected height when SelectHeightIntent is called',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const SelectHeightIntent(height: 180),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.height,
          'height',
          equals(180),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits state with selected weight when SelectWeightIntent is called',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const SelectWeightIntent(weight: 75),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.weight,
          'weight',
          equals(75),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits state with selected age when SelectAgeIntent is called',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const SelectAgeIntent(age: 25),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.age,
          'age',
          equals(25),
        ),
      ],
    );
  });

  group('RegisterCubit goal and level selection', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits state with selected goal when SelectGoalIntent is called',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const SelectGoalIntent(goal: 'Gain Weight'),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.goal,
          'goal',
          equals('Gain Weight'),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits state with selected level when SelectLevelIntent is called',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const SelectLevelIntent(level: ActivityLevel.level1),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.level,
          'level',
          equals(ActivityLevel.level1),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits state with different activity level',
      build: () => registerCubit,
      act: (cubit) => cubit.doIntent(
        intent: const SelectLevelIntent(level: ActivityLevel.level3),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.level,
          'level',
          equals(ActivityLevel.level3),
        ),
      ],
    );
  });

  group('RegisterCubit typing status', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits state with isTyping true when all fields are filled',
      build: () => registerCubit,
      act: (cubit) {
        // No need to call RegisterInitializationIntent - already done in setUp
        cubit.firstNameController.text = 'omar';
        cubit.lastNameController.text = 'elsadany';
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'password123';
        cubit.doIntent(intent: const IsTypingIntent());
      },
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.isTyping,
          'isTyping',
          equals(true),
        ),
      ],
    );
  });

  group('RegisterCubit form validation', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits state with isBasicInfoValid true when validation succeeds',
      build: () => registerCubit,
      act: (cubit) {
        cubit.firstNameController.text = 'omar';
        cubit.lastNameController.text = 'elsadany';
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'password123';
        cubit.doIntent(intent: const ValidateBasicInfoIntent());
      },
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.isBasicInfoValid,
          'isBasicInfoValid',
          equals(true),
        ),
      ],
    );
  });

  group('RegisterCubit registration', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, success] when register is successful',
      build: () {
        when(mockRegisterUseCase.register(any))
            .thenAnswer((_) async => expectedRegisterSuccessResult);
        return registerCubit;
      },
      act: (cubit) {
        // No need to call RegisterInitializationIntent - already done in setUp
        cubit.firstNameController.text = 'omar';
        cubit.lastNameController.text = 'elsadany';
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'password123';
        cubit.doIntent(
          intent: const ChangeGenderIntent(selectedGender: 'male'),
        );
        cubit.doIntent(intent: const SelectHeightIntent(height: 180));
        cubit.doIntent(intent: const SelectWeightIntent(weight: 75));
        cubit.doIntent(intent: const SelectAgeIntent(age: 25));
        cubit.doIntent(intent: const SelectGoalIntent(goal: 'Gain Weight'));
        cubit.doIntent(intent: const SelectLevelIntent(level: ActivityLevel.level1));
        cubit.doIntent(intent: const RegisterFormIntent());
      },
      skip: 6, // Skip: gender + height + weight + age + goal + level (no init needed)
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.registerStatus.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<RegisterState>().having(
          (state) => state.registerStatus.isSuccess,
          'isSuccess',
          equals(true),
        ),
      ],
      verify: (cubit) {
        verify(mockRegisterUseCase.register(any)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, failure] when register is unsuccessful',
      build: () {
        when(mockRegisterUseCase.register(any))
            .thenAnswer((_) async => expectedRegisterFailureResult);
        return registerCubit;
      },
      act: (cubit) {
        // No need to call RegisterInitializationIntent - already done in setUp
        cubit.firstNameController.text = 'omar';
        cubit.lastNameController.text = 'elsadany';
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'password123';
        cubit.doIntent(
          intent: const ChangeGenderIntent(selectedGender: 'male'),
        );
        cubit.doIntent(intent: const SelectHeightIntent(height: 180));
        cubit.doIntent(intent: const SelectWeightIntent(weight: 75));
        cubit.doIntent(intent: const SelectAgeIntent(age: 25));
        cubit.doIntent(intent: const SelectGoalIntent(goal: 'Gain Weight'));
        cubit.doIntent(intent: const SelectLevelIntent(level: ActivityLevel.level1));
        cubit.doIntent(intent: const RegisterFormIntent());
      },
      skip: 6, // Skip: gender + height + weight + age + goal + level
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.registerStatus.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<RegisterState>().having(
          (state) => state.registerStatus.isFailure,
          'isFailure',
          equals(true),
        ),
      ],
      verify: (cubit) {
        verify(mockRegisterUseCase.register(any)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits failure with error message when register fails with ResponseException',
      build: () {
        when(mockRegisterUseCase.register(any)).thenAnswer(
          (_) async => FailedResult(
         'Email already exists',
          ),
        );
        return registerCubit;
      },
      act: (cubit) {
        // No need to call RegisterInitializationIntent - already done in setUp
        cubit.firstNameController.text = 'omar';
        cubit.lastNameController.text = 'elsadany';
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'password123';
        cubit.doIntent(intent: const RegisterFormIntent());
      },
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.registerStatus.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<RegisterState>()
            .having(
              (state) => state.registerStatus.isFailure,
              'isFailure',
              equals(true),
            )
            .having(
              (state) => state.error,
              'error message',
              equals('Email already exists'),
            ),
      ],
      verify: (cubit) {
        verify(mockRegisterUseCase.register(any)).called(1);
      },
    );
  });

  group('RegisterCubit multiple state changes', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits correct states when multiple intents are called in sequence',
      build: () => registerCubit,
      act: (cubit) => [
        cubit.doIntent(
          intent: const ChangeGenderIntent(selectedGender: 'male'),
        ),
        cubit.doIntent(intent: const SelectHeightIntent(height: 180)),
        cubit.doIntent(intent: const SelectWeightIntent(weight: 75)),
        cubit.doIntent(intent: const SelectAgeIntent(age: 25)),
      ],
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedGender,
          'selectedGender',
          equals('male'),
        ),
        isA<RegisterState>()
            .having(
              (state) => state.selectedGender,
              'selectedGender',
              equals('male'),
            )
            .having(
              (state) => state.height,
              'height',
              equals(180),
            ),
        isA<RegisterState>()
            .having(
              (state) => state.selectedGender,
              'selectedGender',
              equals('male'),
            )
            .having(
              (state) => state.height,
              'height',
              equals(180),
            )
            .having(
              (state) => state.weight,
              'weight',
              equals(75),
            ),
        isA<RegisterState>()
            .having(
              (state) => state.selectedGender,
              'selectedGender',
              equals('male'),
            )
            .having(
              (state) => state.height,
              'height',
              equals(180),
            )
            .having(
              (state) => state.weight,
              'weight',
              equals(75),
            )
            .having(
              (state) => state.age,
              'age',
              equals(25),
            ),
      ],
    );
  });
}