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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? isSweet;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.size,
      this.createdAt,
      this.updatedAt,
      this.isSweet});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<dynamic, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel copyWith(
      {String? id,
      String? name,
      double? price,
      double? smallPrice,
      double? largePrice,
      String? size,
      int? quantitiy,
      String? isSweet,
      String? description}) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      size: size ?? this.size,
      isSweet: isSweet ?? this.isSweet,
    );
  } /*  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, name, description, image, size, price, smallPrice, largePrice, quantitiy, createdAt, updatedAt, isSweet]; */
}
