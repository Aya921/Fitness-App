import 'package:dio/dio.dart';
import 'package:fitness/core/error/api_error.dart';
import 'package:fitness/core/result/result.dart';

import '../error/response_exception.dart';


Future<Result<T>> safeApiCall<T>(Future<T> Function() call) async {
  try {

    final response = await call();
    return SuccessResult(response );
  } on Exception catch (error) {
    if (error is DioException) {
      return FailedResult(ServerFailure.fromDioError(error).error);
    }
    else if (error is ResponseException) {
      return FailedResult(ResponseException(
          message: error.toString()).message);

    }
    else {
      return FailedResult(error.toString());
    }
  } catch (error) {
    return FailedResult(error.toString());
  }
}
