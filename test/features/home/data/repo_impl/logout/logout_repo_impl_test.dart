import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/logout/logout_ds.dart';
import 'package:fitness/features/home/data/repo_impl/logout/logout_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_repo_impl_test.mocks.dart';

@GenerateMocks([LogoutDs])
void main() {
  late MockLogoutDs mockLogoutDs;
  late LogoutRepoImpl logoutRepoImpl;


  setUp(() {
    provideDummy<Result<void>>(FailedResult("Dummy"));
    mockLogoutDs = MockLogoutDs();
    logoutRepoImpl = LogoutRepoImpl(mockLogoutDs);
  });

  group('LogoutRepoImpl', () {
    test(
      'should return SuccessResult when data source logout succeeds',
      () async {
        // arrange
        final successResult = SuccessResult<void>(null);
        when(mockLogoutDs.logout()).thenAnswer((_) async => successResult);

        // act
        final result = await logoutRepoImpl.logout();

        // assert
        expect(result, isA<SuccessResult<void>>());
        verify(mockLogoutDs.logout()).called(1);
      },
    );

    test('should return FailedResult when data source logout fails', () async {
      // arrange
      final failedResult = FailedResult<void>('Logout failed');
      when(mockLogoutDs.logout()).thenAnswer((_) async => failedResult);

      // act
      final result = await logoutRepoImpl.logout();

      // assert
      expect(result, isA<FailedResult<void>>());
      verify(mockLogoutDs.logout()).called(1);
    });

    test('should handle delayed response from data source', () async {
      // arrange
      final successResult = SuccessResult<void>(null);
      when(mockLogoutDs.logout()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return successResult;
      });

      // act
      final result = await logoutRepoImpl.logout();

      // assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockLogoutDs.logout()).called(1);
    });
  });
}
