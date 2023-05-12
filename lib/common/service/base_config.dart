import 'package:dio/dio.dart';

class BaseConfig {
  late Dio dio;
  final String baseUrl = "https://yasincoffee.herokuapp.com/";

  BaseConfig() {
    BaseOptions options = BaseOptions(baseUrl: baseUrl);
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
