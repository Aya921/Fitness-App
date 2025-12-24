import 'package:dio/dio.dart';
import 'package:fitness/core/network/token_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../../core/constants/constants.dart';
import '../di.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio provieDio() {
    final dio = Dio();
    dio.interceptors.add(getIt.get<PrettyDioLogger>());
    dio.interceptors.add(getIt.get<TokenInterceptor>());
    dio.options.headers = {Constants.contentType: Constants.appJson};
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    return dio;
  }

  @lazySingleton
  PrettyDioLogger get prettyDioLogger => PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
    responseBody: true,
  );

  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    maxStale: const Duration(days: 2),
  );
}
