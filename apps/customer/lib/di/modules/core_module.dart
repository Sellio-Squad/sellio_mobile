import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:network_inspector/network_inspector.dart';
import 'package:customer/data/core/api/dio_client.dart';

final sl = GetIt.instance;

class CoreModule {
  CoreModule() {
    _core();
  }

  void _core() {
    sl.registerLazySingleton<Dio>(() {
      final dio = DioClient.instance.dio;
      if (kDebugMode) {
        dio.interceptors.add(NetworkInspectorDioInterceptor());
      }
      return dio;
    });
  }
}