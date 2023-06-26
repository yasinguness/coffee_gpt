// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      amount: json['amount'] as int?,
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      currentPrice: (json['currentPrice'] as num?)?.toDouble(),
      selectedSize: json['selectedSize'] as String?,
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currentPrice': instance.currentPrice,
      'selectedSize': instance.selectedSize,
      'product': instance.product,
    };
