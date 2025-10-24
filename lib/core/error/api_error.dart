import 'package:dio/dio.dart';
import '../constants/exception_constant.dart';

abstract class Failure {
  final String error;

  Failure(this.error);
}

class ServerFailure extends Failure {
  ServerFailure(super.error);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {

      case DioExceptionType.connectionTimeout:
        return ServerFailure(ExceptionConstants.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return ServerFailure(ExceptionConstants.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(ExceptionConstants.receiveTimeout);
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(ExceptionConstants.canceled);
      case DioExceptionType.connectionError:
        return ServerFailure(ExceptionConstants.connectionError);
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return ServerFailure(ExceptionConstants.noInternet);
        }
        return ServerFailure(ExceptionConstants.unexpected);
    }
  }

  // will modify

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']);
    } else if (statusCode == 404) {
  final errorMessage =
      response['message'] ?? response['error'] ?? 'Unknown error occurred';
  return ServerFailure(errorMessage);
}
 else if (statusCode == 500) {
      return ServerFailure(ExceptionConstants.internalServer);
    } else {
      return ServerFailure(ExceptionConstants.generalError);
    }
  }
}
