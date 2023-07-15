import '../constants/enums/http_request_enum.dart';

extension NetworkTypeExtension on HttpTypes? {
  String get rawValue {
    switch (this) {
      case HttpTypes.GET:
        return 'GET';
      case HttpTypes.POST:
        return 'POST';
      case HttpTypes.DELETE:
        return 'DELETE';
      case HttpTypes.UPDATE:
        return 'PUT';
      default:
        throw 'Error Type';
    }
  }
}
