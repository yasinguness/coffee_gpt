import 'package:coffe_app/common/constants/enums/http_request_enum.dart';
import 'package:coffe_app/network/base/base_model.dart';
import 'package:coffe_app/network/init/interface/iResponseModel.dart';

abstract class ICoreDioNullSafety {
  Future<IResponseModel<R>> send<R, T>(
    String path, {
    required HttpTypes type,
    required BaseModel<T> parseModel,
    dynamic data,
    Map<String, Object>? queryParameters,
    void Function(int, int)? onReceiveProgress,
  });
}
