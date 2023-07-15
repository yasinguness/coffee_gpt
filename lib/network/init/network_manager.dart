import '../../common/constants/app_const/service_const.dart';
import 'core_dio.dart';
import 'interface/i_core_dio.dart';
import 'package:dio/dio.dart';

class NetworkManager {
  NetworkManager._init() {
    final baseOptions = BaseOptions(
      baseUrl: Coffee_BASE_URL,
    );
    coreDio = CoreDio(baseOptions);
  }
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  ICoreDioNullSafety? coreDio;
}
