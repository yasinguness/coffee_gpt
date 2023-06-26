
/* 
class CoffeeDio with DioMixin implements Dio {
  static CoffeeDio? _instance;

  static CoffeeDio get instance {
    _instance ??= CoffeeDio._init();
    return _instance!;
  }

  CoffeeDio._init() {
    options = BaseOptions(
      baseUrl: "https://yasincoffee.herokuapp.com/",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    );
    httpClientAdapter = BrowserHttpClientAdapter();
  }

  Future make<T extends ServiceModel>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      @required T? parserModel,
      dynamic data,
      @required MethodType? method,
      ProgressCallback? onReceiveProgress}) async {
    final options = Options();
    options.method = getMethodType(method!);
    final body = getBodyModel(data);

    try {
      Response response = await request(path, data: body, options: options);
      //clear();
      return parseBody<T>(response.data, parserModel!);
    } catch (e) {
      return onError(e);
    }
  }

  String? getMethodType(MethodType type) {
    switch (type) {
      case MethodType.GET:
        return "GET";

      case MethodType.POST:
        return "POST";
      default:
        return null;
    }
  }

  dynamic getBodyModel(dynamic data) {
    if (data == null) {
      return data;
    } else if (data is ServiceModel) {
      return data.toJson();
    } else {
      return jsonDecode(data);
    }
  }

  dynamic parseBody<T extends ServiceModel>(dynamic responseBody, T model) {
    try {
      if (responseBody is List) {
        return responseBody.map((data) => model.fromJson(data)).cast<T>().toList();
      } else if (responseBody is Map) {
        return model.fromJson(responseBody) as T;
      } else {
        return responseBody;
      }
    } catch (e) {
      print(e);
      return responseBody;
    }
  }

  onError(Object error) {
    // TODO BASE MODEL
    return "Error";
  }
}

enum MethodType {
  GET,
  POST,
} */
