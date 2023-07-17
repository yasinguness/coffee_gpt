import 'package:coffe_app/network/models/response_model/response_model.dart';

import '../../../network/services/product/product_services.dart';

class TreatRepository {
  Future<ApiResponse> fetchTreat() async {
    ApiResponse response;
    try {
      response = await ProductService().getSweet();
      if (response.statusCode == 200) {
        return response;
      } else {
        return ApiResponse();
      }
    } catch (e) {
      return ApiResponse();
    }
  }
}
