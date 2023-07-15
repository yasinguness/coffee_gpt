// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffe_app/network/base/base_model.dart';
import 'package:coffe_app/network/models/customer/customer.dart';
import 'package:coffe_app/network/models/order_product/order_product.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderModel with BaseModel<OrderModel> {
  @JsonKey(name: "_id")
  String? id;
  CustomerModel? customer;
  List<OrderProductModel>? products;
  String? status;
  double? totalPrice;
  String? createdAt;
  String? updatedAt;
  OrderModel({this.id, this.customer, this.products, this.status, this.createdAt, this.updatedAt, this.totalPrice});

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  @override
  Map<dynamic, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customer == customer &&
        listEquals(other.products, products) &&
        other.status == status &&
        other.totalPrice == totalPrice &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customer.hashCode ^
        products.hashCode ^
        status.hashCode ^
        totalPrice.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  OrderModel fromJson(Map<String, Object> json) {
    // TODO: implement fromJson
    return _$OrderModelFromJson(json);
  }
}
