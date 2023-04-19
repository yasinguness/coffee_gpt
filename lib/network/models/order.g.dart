// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      coffeeList:
          (json['coffeeList'] as List<dynamic>?)?.map((e) => Coffee.fromJson(e as Map<String, dynamic>)).toList(),
      treatList: (json['treatList'] as List<dynamic>?)
          ?.map((e) => e == null ? null : Treat.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
    )
      ..ordersOwner = json['ordersOwner'] as String?
      ..tableNumber = json['tableNumber'] as int?
      ..totalPrice = (json['totalPrice'] as num?)?.toDouble()
      ..isPreparing = json['isPreparing'] as bool?
      ..isCompleted = json['isCompleted'] as bool?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'ordersOwner': instance.ordersOwner,
      'coffeeList': instance.coffeeList,
      'treatList': instance.treatList,
      'tableNumber': instance.tableNumber,
      'totalPrice': instance.totalPrice,
      'time': instance.time?.toIso8601String(),
      'isPreparing': instance.isPreparing,
      'isCompleted': instance.isCompleted,
    };
