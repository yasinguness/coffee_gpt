import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  String? id;
  String? image;
  double? totalCoffePrice;
  double? totalTreatPrice;

  Order({this.id, this.image, this.totalCoffePrice, this.totalTreatPrice});
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<dynamic, dynamic> toJson() => _$OrderToJson(this);
}
