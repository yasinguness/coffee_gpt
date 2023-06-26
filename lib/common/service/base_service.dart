import 'package:dio/dio.dart';

import '../constants/service_const.dart';

abstract class BaseService {
  late Dio dio;

  BaseService() {
    dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    ));

    // Interceptors can be added here, such as logging or auth interceptors
    // dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
