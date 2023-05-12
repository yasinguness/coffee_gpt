// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      largePrice: (json['largePrice'] as num?)?.toDouble(),
      smallPrice: (json['smallPrice'] as num?)?.toDouble(),
      size: json['size'] as String?,
      quantitiy: json['quantitiy'] as int?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
      isSweet: json['isSweet'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'size': instance.size,
      'price': instance.price,
      'smallPrice': instance.smallPrice,
      'largePrice': instance.largePrice,
      'quantitiy': instance.quantitiy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isSweet': instance.isSweet,
    };
