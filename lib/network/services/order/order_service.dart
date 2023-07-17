import 'package:coffe_app/network/api.dart';
import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/models/response_model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'order_service.g.dart';

@RestApi()
abstract class OrderService {
  factory OrderService({Dio? dio}) => _OrderService(dio ?? DioApi.instance.createDio());

  @GET("/order/get-order")
  Future<ApiResponse<List<OrderModel>>> fetchOrders();

  @POST("order/create")
  Future<ApiResponse<bool>> postOrder(@Body() OrderModel model);

  @GET("order/{id}")
  Future<ApiResponse<OrderModel>> getOrderById(@Path("id") id);
}
