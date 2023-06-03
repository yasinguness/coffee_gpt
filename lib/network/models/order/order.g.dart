// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['_id'] as String?,
      customer: json['customer'] == null ? null : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) => <String, dynamic>{
      '_id': instance.id,
      'customer': instance.customer,
      'products': instance.products,
      'status': instance.status,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
