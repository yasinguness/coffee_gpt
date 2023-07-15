// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffe_app/network/base/base_model.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_product.g.dart';

@JsonSerializable()
class OrderProductModel with BaseModel {
  int? amount;
  double? currentPrice;
  String? selectedSize;
  ProductModel? product;

  OrderProductModel({this.amount, this.product, this.currentPrice, this.selectedSize});

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => _$OrderProductModelFromJson(json);
  @override
  Map<dynamic, dynamic> toJson() => _$OrderProductModelToJson(this);

  @override
  fromJson(Map<String, Object> json) {
    _$OrderProductModelFromJson(json);
  }

  @override
  bool operator ==(covariant OrderProductModel other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.currentPrice == currentPrice &&
        other.selectedSize == selectedSize &&
        other.product == product;
  }

  @override
  int get hashCode {
    return amount.hashCode ^ currentPrice.hashCode ^ selectedSize.hashCode ^ product.hashCode;
  }
}
