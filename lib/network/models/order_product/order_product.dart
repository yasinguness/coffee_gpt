import 'package:coffe_app/network/models/product/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_product.g.dart';

@JsonSerializable()
class OrderProductModel {
  int? amount;
  double? currentPrice;
  String? selectedSize;
  ProductModel? product;

  OrderProductModel({this.amount, this.product, this.currentPrice, this.selectedSize});

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => _$OrderProductModelFromJson(json);
  Map<dynamic, dynamic> toJson() => _$OrderProductModelToJson(this);
}
