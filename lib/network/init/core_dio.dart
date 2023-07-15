import 'dart:io';

import 'package:dio/dio.dart';

import '../../common/constants/enums/http_request_enum.dart';
import '../../common/extension/network_extension.dart';
import '../base/base_error.dart';
import '../base/base_model.dart';
import 'interface/iResponseModel.dart';
import 'interface/i_core_dio.dart';

part '../init/core_operation/core_operations.dart';

class CoreDio with DioMixin implements Dio, ICoreDioNullSafety {
  CoreDio(this.options) {
    //options = options;
    interceptors.add(InterceptorsWrapper());
    httpClientAdapter = HttpClientAdapter();
  }
  @override
  final BaseOptions options;

  @override
  Future<IResponseModel<R>> send<R, T>(
    String path, {
    required HttpTypes type,
    required BaseModel<T> parseModel,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final response = await request<dynamic>(
      path,
      data: data,
      options: Options(
        method: type.rawValue,
      ),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.accepted:
        final model = _responseParser<R, T>(parseModel, response.data);
        return ResponseModel<R>(data: model);
      default:
        return ResponseModel(error: BaseError('message'));
    }
  }
}
