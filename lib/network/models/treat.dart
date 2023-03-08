import 'package:json_annotation/json_annotation.dart';
part 'treat.g.dart';

@JsonSerializable()
class Treat {
  final String? id;
  final String? name;
  final String? description;
  final String? colories;
  final String? image;
  final String? price;

  Treat(
      {required this.id,
      required this.name,
      required this.colories,
      required this.description,
      required this.image,
      required this.price});

  factory Treat.fromJson(Map<String, dynamic> json) => _$TreatFromJson(json);
  Map<String, dynamic> toJson() => _$TreatToJson(this);
}
