import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class ProductModel {
  String? id;
  String? name;
  String? description;
  String? image;
  String? size;
  double? price;
  double? smallPrice;
  double? largePrice;
  int? quantitiy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? isSweet;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.largePrice,
      this.smallPrice,
      this.size,
      this.quantitiy,
      this.createdAt,
      this.updatedAt,
      this.isSweet});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<dynamic, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel copyWith(
      {String? name,
      double? price,
      double? smallPrice,
      double? largePrice,
      String? size,
      int? quantitiy,
      String? isSweet,
      String? description}) {
    return ProductModel(
      name: name ?? this.name,
      price: price ?? this.price,
      smallPrice: smallPrice ?? this.smallPrice,
      largePrice: largePrice ?? this.largePrice,
      description: description ?? this.description,
      size: size ?? this.size,
      quantitiy: quantitiy ?? this.quantitiy,
      isSweet: isSweet ?? this.isSweet,
    );
  } /*  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, name, description, image, size, price, smallPrice, largePrice, quantitiy, createdAt, updatedAt, isSweet]; */
}
