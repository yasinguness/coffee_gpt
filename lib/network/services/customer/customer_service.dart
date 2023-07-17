import 'package:coffe_app/network/api.dart';
import 'package:coffe_app/network/models/customer/customer.dart';
import 'package:coffe_app/network/models/response_model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'customer_service.g.dart';

@RestApi()
abstract class CustomerService {
  factory CustomerService({Dio? dio}) => _CustomerService(dio ?? DioApi.instance.createDio());

  @GET("/customer")
  Future<ApiResponse<List<CustomerModel>>> fetchCustomers();

  @POST("/customer")
  Future<ApiResponse<CustomerModel>> createCustomer(@Body() CustomerModel? body);

  @GET("/customer/{id}")
  Future<ApiResponse<CustomerModel>> getCustomerById(@Path("id") String id);
}
