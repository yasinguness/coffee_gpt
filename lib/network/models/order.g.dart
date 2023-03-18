// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      image: json['image'] as String?,
      totalCoffeePrice: (json['totalCoffeePrice'] as num?)?.toDouble(),
      totalTreatPrice: json['totalTreatPrice'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'totalCoffeePrice': instance.totalCoffeePrice,
      'totalTreatPrice': instance.totalTreatPrice,
    };
