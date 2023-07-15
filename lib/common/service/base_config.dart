import 'package:dio/dio.dart';

import '../constants/app_const/service_const.dart';

class BaseConfig {
  late Dio dio;

  BaseConfig() {
    BaseOptions options = BaseOptions(baseUrl: Coffee_BASE_URL);
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (e, handler) async {
        return handler.next(e);
      },
      onError: (e, handler) async {
        return handler.next(e);
      },
    ));
  }
}
