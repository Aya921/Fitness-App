// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart' as _i695;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/api/client/auth_api_services.dart' as _i896;
import '../../features/auth/api/data_source_impl/local/auth_local_ds_impl.dart'
    as _i204;
import '../../features/auth/api/data_source_impl/remote/auth_remote_ds_impl.dart'
    as _i969;
import '../../features/auth/data/data_source/local/auth_local_ds.dart' as _i945;
import '../../features/auth/data/data_source/remote/auth_remote_ds.dart'
    as _i146;
import '../../features/auth/data/repository_impl/auth_repo_impl.dart' as _i4;
import '../../features/auth/domain/repository/auth_repo.dart' as _i976;
import '../app_language/app_language_config.dart' as _i549;
import 'modules/dio_modules.dart' as _i288;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i695.CacheOptions>(() => dioModule.cacheOptions);
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioModule.prettyDioLogger);
    gh.lazySingleton<_i361.Dio>(() => dioModule.provieDio());
    gh.factory<_i896.AuthApiServices>(() => _i896.AuthApiServices(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.singleton<_i549.AppLanguageConfig>(() => _i549.AppLanguageConfig(
        sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i146.AuthRemoteDs>(
        () => _i969.AuthRemoteDsImpl(gh<_i896.AuthApiServices>()));
    gh.factory<_i945.AuthLocalDs>(
        () => _i204.AuthLocalDsImpl(gh<_i896.AuthApiServices>()));
    gh.factory<_i976.AuthRepo>(() => _i4.AuthRepoImpl(
          gh<_i146.AuthRemoteDs>(),
          gh<_i945.AuthLocalDs>(),
        ));
    return this;
  }
}

class _$DioModule extends _i288.DioModule {}
