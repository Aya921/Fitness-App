import 'package:fitness/core/error/api_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

void main() {
  group('ServerFailure.fromDioError', () {
    test('returns correct message for connectionTimeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, 'ServerFailure with Api Server');
    });

    test('returns correct message for sendTimeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.sendTimeout,
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, 'sendTimeout with Api Server');
    });

    test('returns correct message for receiveTimeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.receiveTimeout,
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, 'receiveTimeout with Api Server');
    });

    test('returns correct message for cancel', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.cancel,
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, ' ServerFailure with Api Server was canceled');
    });

    test('returns correct message for connectionError', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionError,
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, ' ServerFailure with Api Server have an error');
    });

    test('returns No Internet Connection for SocketException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.unknown,
        message: 'SocketException: Failed host lookup',
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, 'No Internet Connection');
    });

    test('returns Unexpected Error for unknown non-SocketException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.unknown,
        message: 'Some other error',
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, 'Unexpected Error, Please try again!');
    });

    test('returns correct message for 404 response', () {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
        data: {'message': 'not found'},
      );
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: response,
        type: DioExceptionType.badResponse,
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, 'Your request not found, Please try later!');
    });

    test('returns correct message for 401 response', () {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 401,
        data: {'error': {'message': 'Unauthorized'}},
      );
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: response,
        type: DioExceptionType.badResponse,
      );

      final failure = ServerFailure.fromDioError(dioError);
      expect(failure.error, 'Unauthorized');
    });
  });

  group('ServerFailure.fromResponse', () {
    test('handles 400, 401, 403', () {
      final failure = ServerFailure.fromResponse(401, {
        'error': {'message': 'Invalid credentials'}
      });
      expect(failure.error, 'Invalid credentials');
    });

    test('handles 404', () {
      final failure = ServerFailure.fromResponse(404, {});
      expect(failure.error, 'Your request not found, Please try later!');
    });

    test('handles 500', () {
      final failure = ServerFailure.fromResponse(500, {});
      expect(failure.error, 'Internal Server error, Please try later');
    });

    test('handles unknown status code', () {
      final failure = ServerFailure.fromResponse(999, {});
      expect(failure.error, 'Opps There was an Error, Please try again');
    });
  });
}
