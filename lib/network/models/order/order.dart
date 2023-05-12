import 'package:coffe_app/network/models/customer/customer.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class OrderModel {
  String? id;
  CustomerModel? customer;
  List<ProductModel>? products;
  String? status;
  String? createdAt;
  String? updatedAt;
  OrderModel({this.id, this.customer, this.products, this.status, this.createdAt, this.updatedAt});

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<dynamic, dynamic> toJson() => _$OrderModelToJson(this);
}
