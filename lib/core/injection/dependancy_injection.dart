import 'dart:io';
import 'package:biometric_dashboard/Domain/repositories/repository.dart';
import 'package:biometric_dashboard/Domain/services/services.dart';
import 'package:biometric_dashboard/core/interceptor/dio_connectivity_request_retrier.dart';
import 'package:biometric_dashboard/core/navigator_service/navigator_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  //!-Navigator Service
  sl.registerLazySingleton(
    () => NavigationService(),
  );
  //!--Dio Cache Config
  sl.registerLazySingleton(
    () => CacheConfig(),
  );
  //!--Dio cache Manager
  sl.registerLazySingleton(
    () => DioCacheManager(
      sl(),
    ),
  );
  //!--Connectivity
  sl.registerLazySingleton(
    () => Connectivity(),
  );
  //!--Connectivity
  sl.registerLazySingleton(
    () => DioConnectivityRequestRetrier(
      connectivity: sl(),
      dio: sl(),
    ),
  );
  //!--Dio cache duration
  sl.registerLazySingleton(
    () => buildCacheOptions(Duration(hours: 1), forceRefresh: false),
  );
  //!--Dio Connectivity
  sl.registerLazySingleton(
    () => new Dio()
      ..options.headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      }
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) async {
            //! we can do some edit to the header like
            //! if token != null add the token to the header

            return options;
          },
          onResponse: (Response response) {
            return response; // continue
          },
          onError: (DioError e) async {
            if (_shouldRetry(e)) {
              try {
                //! retry to connect
                return sl<DioConnectivityRequestRetrier>()
                    .scheduleRequestRetry(e.request);
              } catch (error) {
                //! Let any new error from the retrier pass through
                return error;
              }
            }
            if (e.response.statusCode == 401) {
              //! here we set the logout with delete token and go to the login page
              //! Unauthorized Error
            }
            print(e);
            return e;
          },
        ),
      )
      ..interceptors.add(
        sl<DioCacheManager>().interceptor,
      ),
  );
  //! Repository
  sl.registerLazySingleton(
    () => Repositories(
      services: sl(),
    ),
  );
  //! Service
  sl.registerLazySingleton(
    () => Services(
      dio: sl(),
      options: sl(),
    ),
  );
}

//! Error function
bool _shouldRetry(DioError err) {
  return err.type == DioErrorType.DEFAULT &&
      err.error != null &&
      err.error is SocketException;
}
