import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  late RequestOptions _options;
  final Dio dio;

  AppInterceptor(this.dio);
  final Connectivity _connectivity = Connectivity();

  Future<bool> networkControl() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      return true;
    }

    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final response = await networkControl();

    if (response) {
      _options = options;

      log(_options.uri.toString());
      handler.next(options);
    } else {
      //AppState.of(context).setTransactionState(TransactionState.networkError, index);

      handler.reject(DioException(requestOptions: options));
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /*    if (status == 401) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        UserModel(context).logout();
      });
    } else {
      handler.next(response);
    } */

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      handler.resolve(err.response!);
    } else {
      handler.reject(err);
    }
  }
}
