import 'package:coffe_app/common/constants/service_const.dart';
import 'package:coffe_app/network/interceptor/app_interceptor.dart';
import 'package:dio/dio.dart';

class DioApi {
  static DioApi? _instance;
  static DioApi get instance {
    _instance ??= DioApi._init();
    return _instance!;
  }

  DioApi._init();

  Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiPath.BASE_URL,
      contentType: "application/json",
      connectTimeout: const Duration(milliseconds: 10000),
    ));
    dio.interceptors.add(AppInterceptor(dio));
    return dio;
  }
}
