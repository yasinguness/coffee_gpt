import 'package:json_annotation/json_annotation.dart';
part 'coffee.g.dart';

@JsonSerializable()
class Coffee {
  String? id;
  String? name;
  String? description;
  String? image;
  String? coffeeSize;
  double? smallPrice;
  double? mediumPrice;
  double? largePrice;
  int? quantitiy;

  Coffee(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.smallPrice,
      this.largePrice,
      this.mediumPrice,
      this.coffeeSize,
      this.quantitiy});

  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);
  Map<dynamic, dynamic> toJson() => _$CoffeeToJson(this);
}
