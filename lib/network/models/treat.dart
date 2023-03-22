import 'package:json_annotation/json_annotation.dart';
part 'treat.g.dart';

@JsonSerializable()
class Treat {
  String? id;
  String? name;
  String? description;
  String? colories;
  String? image;
  String? price;
  int? quantity;

  Treat({this.id, this.name, this.colories, this.description, this.image, this.price, this.quantity});

  factory Treat.fromJson(Map<String, dynamic> json) => _$TreatFromJson(json);
  Map<String, dynamic> toJson() => _$TreatToJson(this);
}
