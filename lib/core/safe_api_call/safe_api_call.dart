import 'package:dio/dio.dart';
import 'package:fitness/core/error/api_error.dart';
import 'package:fitness/core/result/result.dart';

Future<Result<T>> safeApiCall<T>(Future<Result<T>> Function() call) async {
  try {
    final response = await call();
    return SuccessResult(response as T);
  } on Exception catch (error) {
    if (error is DioException) {
      return FailedResult(ServerFailure.fromDioError(error).error);
    } else {
      return FailedResult(error.toString());
    }
  } catch (error) {
    return FailedResult(error.toString());
  }
}

