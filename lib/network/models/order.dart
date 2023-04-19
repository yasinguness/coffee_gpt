import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/models/treat.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  String? id;
  String? ordersOwner;
  List<Coffee>? coffeeList;
  List<Treat?>? treatList;
  int? tableNumber;
  double? totalPrice;
  DateTime? time;
  bool? isPreparing;
  bool? isCompleted;

  Order({this.id, this.coffeeList, this.treatList, this.time});
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<dynamic, dynamic> toJson() => _$OrderToJson(this);
}
