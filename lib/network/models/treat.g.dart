// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Treat _$TreatFromJson(Map<String, dynamic> json) => Treat(
      id: json['id'] as String?,
      name: json['name'] as String?,
      colories: json['colories'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$TreatToJson(Treat instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'colories': instance.colories,
      'image': instance.image,
      'price': instance.price,
    };