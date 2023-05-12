import 'package:coffe_app/common/constants/service_const.dart';
import 'package:dio/dio.dart';

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
/* 
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get<T>(path, queryParameters: queryParameters);
      return response;
    } on DioError {
      // Handle errors here
      rethrow;
    }
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    try {
      final response = await dio.post<T>(path, data: data);
      return response;
    } on DioError {
      // Handle errors here
      rethrow;
    }
  } */

  // Additional HTTP methods can be added here, such as PUT, PATCH, DELETE, etc.
}
