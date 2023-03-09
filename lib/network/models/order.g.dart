// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      image: json['image'] as String?,
      totalCoffePrice: (json['totalCoffePrice'] as num?)?.toDouble(),
      totalTreatPrice: (json['totalTreatPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'totalCoffePrice': instance.totalCoffePrice,
      'totalTreatPrice': instance.totalTreatPrice,
    };
