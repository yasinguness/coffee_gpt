import 'dart:async';

import 'package:coffe_app/network/api.dart';
import 'package:coffe_app/network/models/response_model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/product/product.dart';

part 'product_services.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService({Dio? dio}) => _ProductService(dio ?? DioApi.instance.createDio());

  @GET("/product")
  Future<ApiResponse<List<ProductModel>>> fetchProducts();

  @GET("/product/sweet")
  Future<ApiResponse<List<ProductModel>>> getSweet();

  @GET("/product/coffees")
  Future<ApiResponse<List<ProductModel>>> getCoffees();

  @GET("/product/{id}")
  Future<ApiResponse<ProductModel>> getProductById(@Path("id") id);
}
