import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/chage_pass/change_pass_request.dart';
import 'package:fitness/features/home/domain/usecase/change_pass_usecase/change_pass_usecase.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_event.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_pass_cubit_test.mocks.dart';

@GenerateMocks([ChangePassUsecase])
void main() {
  late MockChangePassUsecase mockChangePassUsecase;
  late ChangePassCubit cubit;

  setUp(() {
    provideDummy<Result<void>>(SuccessResult<void>(null));
    mockChangePassUsecase = MockChangePassUsecase();
    cubit = ChangePassCubit(mockChangePassUsecase);
  });

  tearDown(() {
    cubit.close();
  });

  final tRequest = ChangePassRequest(
    password: 'oldPassword123',
    newPassword: 'newPassword456',
  );

  group('ChangePassCubit', () {
    test('initial state should be ChangePassState()', () {
      expect(cubit.state, const ChangePassState());
    });

    test('should emit [loading, success] when changePass succeeds', () async {
      // Arrange
      when(mockChangePassUsecase.changePass(req: tRequest))
          .thenAnswer((_) async => SuccessResult<void>(null));

      // Assert Later
      final expectedStates = [
        const ChangePassState(
          changePassStatus: StateStatus<void>.loading(),
        ),
        const ChangePassState(
          changePassStatus: StateStatus<void>.success(null),
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      // Act
      await cubit.doIntent(SendPassAndNewPassEvent(changePassRequest: tRequest));

      // Verify usecase called once
      verify(mockChangePassUsecase.changePass(req: tRequest)).called(1);
    });

    test('should emit [loading, failure] when changePass fails', () async {
      // Arrange
      const errorMessage = 'Invalid old password';
      when(mockChangePassUsecase.changePass(req: tRequest))
          .thenAnswer((_) async => FailedResult<void>(errorMessage));

      // Assert Later
      final expectedStates = [
        const ChangePassState(
          changePassStatus: StateStatus<void>.loading(),
        ),
        const ChangePassState(
          changePassStatus: StateStatus<void>.failure(
             ResponseException(message: errorMessage),
          ),
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      // Act
      await cubit.doIntent(SendPassAndNewPassEvent(changePassRequest: tRequest));

      // Verify usecase called once
      verify(mockChangePassUsecase.changePass(req: tRequest)).called(1);
    });

    test('should handle multiple calls correctly', () async {
      // Arrange
      when(mockChangePassUsecase.changePass(req: tRequest))
          .thenAnswer((_) async => SuccessResult<void>(null));

      // Act
      await cubit.doIntent(SendPassAndNewPassEvent(changePassRequest: tRequest));
      await cubit.doIntent(SendPassAndNewPassEvent(changePassRequest: tRequest));

      // Assert
      verify(mockChangePassUsecase.changePass(req: tRequest)).called(2);
    });
  });
}
