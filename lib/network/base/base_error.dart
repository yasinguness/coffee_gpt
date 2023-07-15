import '../init/interface/iResponseModel.dart';

class BaseError<T> extends IErrorModel<T> {
  BaseError(this.message);
  final String message;
}
