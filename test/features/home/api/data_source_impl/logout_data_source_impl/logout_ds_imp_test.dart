import 'dart:io';
import 'package:fitness/features/home/api/data_source_impl/logout_data_source_impl/logout_ds_imp.dart';
import 'package:fitness/features/home/api/models/logout/logout_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/api/client/api_services.dart';

import 'logout_ds_imp_test.mocks.dart';


@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late LogoutDsImp logoutDsImp;

  setUp(() {
    mockApiServices = MockApiServices();
    logoutDsImp = LogoutDsImp(mockApiServices);
  });

  final LogoutResponse fakeResponse=LogoutResponse(message: "logout");
  group('LogoutDsImp', () {
    test('should call ApiServices.logout() and return Success when successful', () async {
      // arrange
      when(mockApiServices.logout()).thenAnswer((_) async=> fakeResponse, );

      // act
      final result = await logoutDsImp.logout();

      // assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockApiServices.logout()).called(1);
    });

    test('should return Failure when ApiServices.logout() throws an exception', () async {
      // arrange
      when(mockApiServices.logout()).thenThrow(Exception('Logout failed'));

      // act
      final result = await logoutDsImp.logout();

      // assert
      verify(mockApiServices.logout()).called(1);
      expect(result, isA<FailedResult<void>>());
    });

    test('should return Failure when network timeout occurs', () async {
      // arrange
      when(mockApiServices.logout()).thenThrow(
        const SocketException('Connection timeout'),
      );

      // act
      final result = await logoutDsImp.logout();


      // assert
      verify(mockApiServices.logout()).called(1);
      expect(result, isA<FailedResult<void>>());
    });

    test('should complete without hanging when API is slow', () async {
      // arrange
      when(mockApiServices.logout()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return fakeResponse;
      });

      // act
      final result = await logoutDsImp.logout();

      // assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockApiServices.logout()).called(1);
    });
  });
}
