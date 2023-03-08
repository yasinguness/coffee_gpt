import 'package:json_annotation/json_annotation.dart';
part 'coffee.g.dart';

@JsonSerializable()
class Coffee {
  String? id;
  String? name;
  String? description;
  String? image;
  double? smallPrice;
  double? mediumPrice;
  double? largePrice;

  Coffee({this.id, this.name, this.description, this.image, this.smallPrice, this.largePrice, this.mediumPrice});

  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);
  Map<dynamic, dynamic> toJson() => _$CoffeeToJson(this);
}
