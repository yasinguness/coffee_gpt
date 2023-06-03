import 'package:coffe_app/network/models/customer/customer.dart';
import 'package:coffe_app/network/models/order_product/order_product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderModel {
  String? id;
  CustomerModel? customer;
  List<OrderProductModel>? products;
  String? status;
  double? totalPrice;
  String? createdAt;
  String? updatedAt;
  OrderModel({this.id, this.customer, this.products, this.status, this.createdAt, this.updatedAt, this.totalPrice});

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<dynamic, dynamic> toJson() => _$OrderModelToJson(this);
}
