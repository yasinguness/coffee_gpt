import 'package:coffe_app/network/models/response_model/response_model.dart';

import '../../../network/models/customer/customer.dart';
import '../../../network/services/customer/customer_service.dart';

class LoginRepository {
  Future<ApiResponse> createCustomer(CustomerModel model) async {
    ApiResponse response;

    try {
      response = await CustomerService().createCustomer(model);
      //FlowError.assertEqual(response.procstatus, 201, response);
      if (response.statusCode == 201) {
        return response.data;
      } else {
        return ApiResponse();
      }
    } catch (e) {
      return ApiResponse();
    }
  }
}
