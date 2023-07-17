import '../../../network/models/response_model/response_model.dart';
import '../../../network/services/product/product_services.dart';

class CoffeeListRepository {
  Future<ApiResponse> fetchCoffees() async {
    ApiResponse response;
    try {
      response = await ProductService().getCoffees();
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
