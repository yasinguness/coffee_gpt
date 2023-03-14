// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coffee _$CoffeeFromJson(Map<String, dynamic> json) => Coffee(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      smallPrice: (json['smallPrice'] as num?)?.toDouble(),
      largePrice: (json['largePrice'] as num?)?.toDouble(),
      mediumPrice: (json['mediumPrice'] as num?)?.toDouble(),
    )..coffeeSize = json['coffeeSize'] as String?;

Map<String, dynamic> _$CoffeeToJson(Coffee instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'coffeeSize': instance.coffeeSize,
      'smallPrice': instance.smallPrice,
      'mediumPrice': instance.mediumPrice,
      'largePrice': instance.largePrice,
    };
